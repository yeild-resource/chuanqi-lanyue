%%-*-erlang-*-
%%--------------------------------------------------------------------
%% %CopyrightBegin%
%% 
%% Copyright Ericsson AB 2008-2009. All Rights Reserved.
%% 
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%% 
%% %CopyrightEnd%
%%----------------------------------------------------------------------
%% File    : xmerl_sax_parser_list.erl
%% Description : 
%%
%% Created : 25 Apr 2008 
%%----------------------------------------------------------------------
-module(xmerl_sax_parser_list).

%%----------------------------------------------------------------------
%% Macros
%%----------------------------------------------------------------------
-define(STRING_EMPTY, []).
-define(STRING(MatchStr), MatchStr).
-define(STRING_REST(MatchStr, Rest), MatchStr ++ Rest).
-define(APPEND_STRING(Rest, New), Rest ++ New).
-define(TO_INPUT_FORMAT(Val), Val).

%%  In the list case we can't use a '++' when matchin against an unbound variable 
-define(STRING_UNBOUND_REST(MatchChar, Rest), [MatchChar | Rest]).
-define(BYTE_ORDER_MARK_1, undefined_bom1).
-define(BYTE_ORDER_MARK_2, undefined_bom2).
-define(BYTE_ORDER_MARK_REST(Rest), [undefined|Rest]).
%%-*-erlang-*-
%% %CopyrightBegin%
%% 
%% Copyright Ericsson AB 2008-2012. All Rights Reserved.
%% 
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%% 
%% %CopyrightEnd%
%%----------------------------------------------------------------------
%% Start of common source
%%----------------------------------------------------------------------
%-compile(export_all).

%%----------------------------------------------------------------------
%% Include files
%%----------------------------------------------------------------------
-include("xmerl_sax_parser.hrl").

%%----------------------------------------------------------------------
%% External exports
%%----------------------------------------------------------------------
-export([
	 parse/2,
	 parse_dtd/2,
	 is_name_char/1,
	 is_name_start/1
        ]).

%%----------------------------------------------------------------------
%% Internal exports
%%----------------------------------------------------------------------
-export([
	 cf/3,
	 cf/4,
	 cf/5
        ]).

%%----------------------------------------------------------------------
%% Records
%%----------------------------------------------------------------------

%%----------------------------------------------------------------------
%% Macros
%%----------------------------------------------------------------------
-define(HTTP_DEF_PORT, 80).

%%======================================================================
%% External functions
%%======================================================================
%%----------------------------------------------------------------------
%% Function: parse(Xml, State) -> Result
%% Input:    Xml = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%% Output:   Result = {ok, Rest, EventState} |
%%           EventState = term()
%% Description: Parsing XML from input stream.
%%----------------------------------------------------------------------
parse(Xml, State) ->
    RefTable = ets:new(xmerl_sax_entity_refs, [private]),

    State1 =  event_callback(startDocument, State),

    case catch parse_document(Xml, State1#xmerl_sax_parser_state{ref_table=RefTable}) of
	{ok, Rest, State2} ->
	    State3 =  event_callback(endDocument, State2),
	    ets:delete(RefTable),
	    {ok, State3#xmerl_sax_parser_state.event_state, Rest}; 
	{fatal_error, {State2, Reason}} ->
	    State3 =  event_callback(endDocument, State2),
	    ets:delete(RefTable),
	    format_error(fatal_error, State3, Reason);
	{event_receiver_error, State2, {Tag, Reason}} -> 
	    State3 =  event_callback(endDocument, State2),
	    ets:delete(RefTable),
	    format_error(Tag, State3, Reason);
	Other ->
	    _State2 = event_callback(endDocument, State1),
	    ets:delete(RefTable),
	    throw(Other)
    end.

%%----------------------------------------------------------------------
%% Function: parse_dtd(Xml, State) -> Result
%% Input:    Xml = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%% Output:   Result = {ok, Rest, EventState} |
%%           EventState = term()
%% Description: Parsing XML DTD from input stream.
%%----------------------------------------------------------------------
parse_dtd(Xml, State) ->
    RefTable = ets:new(xmerl_sax_entity_refs, [private]),

    State1 =  event_callback(startDocument, State),

    case catch parse_external_entity_1(Xml, State1#xmerl_sax_parser_state{ref_table=RefTable}) of
	{fatal_error, {State2, Reason}} ->
	    State3 =  event_callback(endDocument, State2),
	    ets:delete(RefTable),
	    format_error(fatal_error, State3, Reason);
	{event_receiver_error, State2, {Tag, Reason}} -> 
	    State3 =  event_callback(endDocument, State2),
	    format_error(Tag, State3, Reason);
	{Rest, State2} when is_record(State2, xmerl_sax_parser_state) ->
	    State3 =  event_callback(endDocument, State2),
	    ets:delete(RefTable),
	    {ok, State3#xmerl_sax_parser_state.event_state, Rest}; 
	{endDocument, Rest, State2} when is_record(State2, xmerl_sax_parser_state) ->
	    State3 =  event_callback(endDocument, State2),
	    ets:delete(RefTable),
	    {ok, State3#xmerl_sax_parser_state.event_state, Rest}; 
	Other ->
	    _State2 = event_callback(endDocument, State1),
	    ets:delete(RefTable),
	    throw(Other)
    end.


%%======================================================================
%% Internal functions
%%======================================================================

%%----------------------------------------------------------------------
%% Function: parse_document(Rest, State) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%% Output:   Result = {ok, Rest, State}
%% Description: Parsing an XML document
%%              [1] document ::= prolog element Misc*
%%----------------------------------------------------------------------
parse_document(Rest, State) when is_record(State, xmerl_sax_parser_state) ->
    {Rest1, State1} = parse_xml_decl(Rest, State),
    {Rest2, State2} = parse_misc(Rest1, State1, true),
    {ok, Rest2, State2}.


%%----------------------------------------------------------------------
%% Function: parse_xml_decl(Rest, State) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%% Output:   Result = {Rest, State}
%% Description: Parsing the xml directive in the prolog.
%%             [22] prolog ::= XMLDecl? Misc* (doctypedecl Misc*)?
%%             [23] XMLDecl ::= '<?xml' VersionInfo EncodingDecl? SDDecl? S? '?>'
%%----------------------------------------------------------------------
parse_xml_decl(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_xml_decl/2);
parse_xml_decl(?BYTE_ORDER_MARK_1, State) ->
    cf(?BYTE_ORDER_MARK_1, State, fun parse_xml_decl/2);
parse_xml_decl(?BYTE_ORDER_MARK_2, State) ->
    cf(?BYTE_ORDER_MARK_2, State, fun parse_xml_decl/2);
parse_xml_decl(?BYTE_ORDER_MARK_REST(Rest), State) ->
    cf(Rest, State, fun parse_xml_decl/2);
parse_xml_decl(?STRING("<") = Bytes, State) ->
    cf(Bytes, State, fun parse_xml_decl/2);
parse_xml_decl(?STRING("<?") = Bytes, State) ->
    cf(Bytes, State, fun parse_xml_decl/2);
parse_xml_decl(?STRING("<?x") = Bytes, State) ->
    cf(Bytes, State, fun parse_xml_decl/2);
parse_xml_decl(?STRING("<?xm") = Bytes, State) ->
    cf(Bytes, State, fun parse_xml_decl/2);
parse_xml_decl(?STRING("<?xml") = Bytes, State) ->
    cf(Bytes, State, fun parse_xml_decl/2);
parse_xml_decl(?STRING_REST("<?xml", Rest1), State) ->
    parse_xml_decl_1(Rest1, State);
parse_xml_decl(Bytes, #xmerl_sax_parser_state{encoding=Enc} = State) when is_binary(Bytes) ->
    case unicode:characters_to_list(Bytes, Enc) of 
	{incomplete, _, _} ->
	    cf(Bytes, State, fun parse_xml_decl/2);
	{error, _Encoded, _Rest} ->
	    ?fatal_error(State,  lists:flatten(io_lib:format("Bad character, not in ~p\n", [Enc])));
	_ ->
	    parse_prolog(Bytes, State)
    end;
parse_xml_decl(Bytes, State) ->
    parse_prolog(Bytes, State).
    

parse_xml_decl_1(?STRING_UNBOUND_REST(C, Rest) = Bytes, State) ->
    if
	?is_whitespace(C) ->
	    {_XmlAttributes, Rest1, State1} = parse_version_info(Rest, State, []),
	    %State2 =  event_callback({processingInstruction, "xml", XmlAttributes}, State1),% The XML decl. should not be reported as a PI
	    parse_prolog(Rest1, State1);
	true ->
	     parse_prolog(?STRING_REST("<?xml", Bytes), State)
    end;	
parse_xml_decl_1(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_xml_decl_1/2], undefined).



%%----------------------------------------------------------------------
%% Function: parse_prolog(Rest, State) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%% Output:   Result = {Rest, State}
%% Description: Parsing XML prolog
%%             [22] prolog ::= XMLDecl? Misc* (doctypedecl Misc*)?
%%----------------------------------------------------------------------
parse_prolog(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_prolog/2);
parse_prolog(?STRING("<") = Bytes, State) ->
    cf(Bytes, State, fun parse_prolog/2);
parse_prolog(?STRING_REST("<?", Rest), State) ->
    case parse_pi(Rest, State) of
	{Rest1, State1} ->
	    parse_prolog(Rest1, State1);
	{endDocument, Rest1, State1} ->
	    parse_prolog(Rest1, State1)  
	    % IValue = ?TO_INPUT_FORMAT("<?"),
	    % {?APPEND_STRING(IValue, Rest1), State1}
    end;
parse_prolog(?STRING_REST("<!", Rest), State) ->
    parse_prolog_1(Rest, State);
parse_prolog(?STRING_REST("<", Rest), State) ->
    parse_stag(Rest, State);
parse_prolog(?STRING_UNBOUND_REST(C, _) = Rest, State) when ?is_whitespace(C) -> 
    {_WS, Rest1, State1} = whitespace(Rest, State, []), 
    parse_prolog(Rest1, State1);
parse_prolog(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_prolog/2], 
			     "expecting < or whitespace").


parse_prolog_1(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_prolog_1/2);
parse_prolog_1(?STRING("D") = Bytes, State) ->
    cf(Bytes, State, fun parse_prolog_1/2);
parse_prolog_1(?STRING("DO") = Bytes, State) ->
    cf(Bytes, State, fun parse_prolog_1/2);
parse_prolog_1(?STRING("DOC") = Bytes, State) ->
    cf(Bytes, State, fun parse_prolog_1/2);
parse_prolog_1(?STRING("DOCT") = Bytes, State) ->
    cf(Bytes, State, fun parse_prolog_1/2);
parse_prolog_1(?STRING("DOCTY") = Bytes, State) ->
    cf(Bytes, State, fun parse_prolog_1/2);
parse_prolog_1(?STRING("DOCTYP") = Bytes, State) ->
    cf(Bytes, State, fun parse_prolog_1/2);
parse_prolog_1(?STRING_REST("DOCTYPE", Rest), State) ->
    {Rest1, State1} = parse_doctype(Rest, State),
    State2 = event_callback(endDTD, State1),
    parse_prolog(Rest1, State2);
parse_prolog_1(?STRING("-"), State) ->
    cf(?STRING("-"), State, fun parse_prolog_1/2);
parse_prolog_1(?STRING_REST("--", Rest), State) ->
	    {Rest1, State1} = parse_comment(Rest, State, []),
	    parse_prolog(Rest1, State1);
parse_prolog_1(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_prolog_1/2], 
			     "expecting comment or DOCTYPE"). 
    


%%----------------------------------------------------------------------
%% Function: parse_version_info(Rest, State, Acc) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%%           Acc = [{Name, Value}]
%%           Name = string()
%%           Value = string()
%% Output:   Result = {[{Name, Value}], Rest, State}
%% Description: Parsing the version number in the XML directive.
%%              [24] VersionInfo ::= S 'version' Eq (' VersionNum ' | " VersionNum ")
%%----------------------------------------------------------------------
parse_version_info(?STRING_EMPTY, State, Acc) ->
    cf(?STRING_EMPTY, State, Acc, fun parse_version_info/3);
parse_version_info(?STRING_UNBOUND_REST(C, _) = Rest, State, Acc) when ?is_whitespace(C) ->
    {_WS, Rest1, State1} = whitespace(Rest, State, []),
    parse_version_info(Rest1, State1, Acc);
parse_version_info(?STRING_UNBOUND_REST(C,Rest), State, Acc) ->
    case is_name_start(C) of 
	true ->
	    case parse_name(Rest, State, [C]) of
		{"version", Rest1, State1} ->
		    {Rest2, State2} = parse_eq(Rest1, State1),
		    {Version, Rest3, State3} = parse_att_value(Rest2, State2), 
		    parse_xml_decl_rest(Rest3, State3, [{"version",Version}|Acc]);
		{_, _, State1} ->
		    ?fatal_error(State1, "expecting attribute version")
	    end;
	false ->
	    ?fatal_error(State, "expecting attribute version")
    end;
parse_version_info(Bytes, State, Acc)   -> 
    unicode_incomplete_check([Bytes, State, Acc, fun parse_version_info/3],
			     undefined). 



%%----------------------------------------------------------------------
%% Function: parse_xml_decl_rest(Rest, State, Acc) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%%           Acc = [{Name, Value}]
%%           Name = string()
%%           Value = string()
%% Output:   Result = {[{Name, Value}], Rest, State}
%% Description: Checks if there is more to parse in the XML directive.
%%----------------------------------------------------------------------     
parse_xml_decl_rest(?STRING_EMPTY, State, Acc) ->
    cf(?STRING_EMPTY, State, Acc, fun parse_xml_decl_rest/3);
parse_xml_decl_rest(?STRING("?") = Rest, State, Acc) ->
    cf(Rest, State, Acc, fun parse_xml_decl_rest/3);
parse_xml_decl_rest(?STRING_REST("?>", Rest), State, Acc) ->
    {lists:reverse(Acc), Rest, State};
parse_xml_decl_rest(?STRING_UNBOUND_REST(C, _) = Rest, State, Acc) when ?is_whitespace(C) ->
    {_WS, Rest1, State1} = whitespace(Rest, State, []),
    parse_xml_decl_encoding(Rest1, State1, Acc);
parse_xml_decl_rest(Bytes, State, Acc) ->
    unicode_incomplete_check([Bytes, State, Acc, fun parse_xml_decl_rest/3],
			     "expecting encoding, standalone, whitespace or ?>").


%%----------------------------------------------------------------------
%% Function: parse_xml_decl_encoding(Rest, State, Acc) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%%           Acc = [{Name, Value}]
%%           Name = string()
%%           Value = string()
%% Output:   Result = {[{Name, Value}], Rest, State}
%% Description: Parse the encoding attribute in the XML directive.
%%              [80] EncodingDecl ::= S 'encoding' Eq ('"' EncName '"' | "'" EncName "'" )
%               [81] EncName ::= [A-Za-z] ([A-Za-z0-9._] | '-')*
%%----------------------------------------------------------------------     
parse_xml_decl_encoding(?STRING_EMPTY, State, Acc) ->
    cf(?STRING_EMPTY, State, Acc, fun parse_xml_decl_encoding/3);
parse_xml_decl_encoding(?STRING_REST("e", Rest), State, Acc) ->
    case parse_name(Rest, State,[$e]) of
	{"encoding", Rest1, State1} ->
	    {Rest2, State2} = parse_eq(Rest1, State1),
	    {Enc, Rest3, State3} = parse_att_value(Rest2, State2), 
	    parse_xml_decl_encoding_1(Rest3, State3, [{"encoding",Enc} |Acc]);
        {Name, _Rest1, State1} ->
	    ?fatal_error(State1, "Attribute " ++ Name ++ 
			 " not allowed in xml declaration")
    end;
parse_xml_decl_encoding(?STRING_UNBOUND_REST(_C, _) = Bytes, State, Acc) -> 
    parse_xml_decl_standalone(Bytes, State, Acc);
parse_xml_decl_encoding(Bytes, State, Acc) ->
    unicode_incomplete_check([Bytes, State, Acc, fun parse_xml_decl_encoding/3], 
			     undefined).


parse_xml_decl_encoding_1(?STRING_UNBOUND_REST(C, _) = Bytes, State, Acc) when ?is_whitespace(C) ->
    {_WS, Rest1, State1} = whitespace(Bytes, State, []),
    parse_xml_decl_standalone(Rest1, State1, Acc);
parse_xml_decl_encoding_1(?STRING_UNBOUND_REST(_C, _) = Bytes, State, Acc) ->
    parse_xml_decl_rest(Bytes, State, Acc);
parse_xml_decl_encoding_1(Bytes, State, Acc) ->
    unicode_incomplete_check([Bytes, State, Acc, fun parse_xml_decl_encoding_1/3], 
			     undefined).


%%----------------------------------------------------------------------
%% Function: parse_xml_decl_standalone(Rest, State, Acc) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%%           Acc = [{Name, Value}]
%%           Name = string()
%%           Value = string()
%% Output:   Result = {[{Name, Value}], Rest, State}
%% Description: Parse the standalone attribute in the XML directive.
%%              [32] SDDecl ::= S 'standalone' Eq (("'" ('yes' | 'no') "'") | 
%%                              ('"' ('yes' | 'no') '"'))
%%----------------------------------------------------------------------   
parse_xml_decl_standalone(?STRING_EMPTY, State, Acc) ->
    cf(?STRING_EMPTY, State, Acc, fun parse_xml_decl_standalone/3);
parse_xml_decl_standalone(?STRING_REST("s", Rest), State, Acc) ->
    case parse_name(Rest, State,[$s]) of
	{"standalone", Rest1, State1} ->
	    {Rest2, State2} = parse_eq(Rest1, State1),
	    {Standalone, Rest3, State3} = parse_att_value(Rest2, State2),
	    case Standalone of
		"yes" -> ok;
		"no" -> ok;
		_ ->
		    ?fatal_error(State3, "Wrong value of attribute standalone in xml declaration, must be yes or no")
	    end,
	    {_WS, Rest4, State4} = whitespace(Rest3, State3, []),
	    parse_xml_decl_rest(Rest4, State4#xmerl_sax_parser_state{standalone=list_to_atom(Standalone)}, 
				[{"standalone",Standalone} |Acc]);
        {Name, _Rest1, State1} ->
	    ?fatal_error(State1, "Attribute " ++ Name ++ 
			 " not allowed in xml declaration")
    end;
parse_xml_decl_standalone(?STRING_UNBOUND_REST(_C, _) = Bytes, State, Acc) -> 
    parse_xml_decl_rest(Bytes, State, Acc);
parse_xml_decl_standalone(Bytes, State, Acc) ->
    unicode_incomplete_check([Bytes, State, Acc, fun parse_xml_decl_standalone/3], 
			     undefined).



%%----------------------------------------------------------------------
%% Function: parse_pi(Rest, State) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%% Output:   Result = {Rest, State}
%% Description: Parse processing instructions.
%%              [16] PI ::= '<?' PITarget (S (Char* - (Char* '?>' Char*)))? '?>'
%%              [17] PITarget ::= Name - (('X' | 'x') ('M' | 'm') ('L' | 'l'))
%%----------------------------------------------------------------------
parse_pi(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_pi/2);
parse_pi(?STRING_UNBOUND_REST(C, Rest) = Bytes, State) ->
    case is_name_start(C) of 
	true ->
	    {PiTarget, Rest1, State1} = 
		parse_name(Rest, State, [C]),
	    case string:to_lower(PiTarget) of  
		"xml" ->
		    case check_if_new_doc_allowed(State#xmerl_sax_parser_state.input_type,
						  State#xmerl_sax_parser_state.end_tags) of
			true ->
			    {endDocument, Bytes, State};
			false ->
			    ?fatal_error(State1, "<?xml  ...?> not first in document")
		    end;
		_ ->
		    {PiData, Rest2, State2} = parse_pi_1(Rest1, State1),
		    State3 =  event_callback({processingInstruction, PiTarget, PiData}, State2),
		    {Rest2, State3}
	    end;
	false ->
	    ?fatal_error(State, "expecting name")
    end;
parse_pi(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_pi/2], undefined).

check_if_new_doc_allowed(stream, []) ->
    true;
check_if_new_doc_allowed(_, _) ->
    false.

%%----------------------------------------------------------------------
%% Function: parse_pi_1(Rest, State) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%% Output:   Result = {Rest, State}
%% Description: Parse processing instructions.
%%----------------------------------------------------------------------
parse_pi_1(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_pi_1/2);
parse_pi_1(?STRING_UNBOUND_REST(C,_) = Rest, State) when ?is_whitespace(C) ->
    {_WS, Rest1, State1} =  
		whitespace(Rest, State, []),
    parse_pi_data(Rest1, State1, []);
parse_pi_1(?STRING_REST("?>", Rest), State) ->
    {[], Rest, State};
parse_pi_1(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_pi/2],
			     "expecting whitespace or '?>'").


%%----------------------------------------------------------------------
%% Function: parse_name(Rest, State, Acc) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%%           Acc = string()
%% Output:   Result = {Name, Rest, State}
%%           Name = string()
%% Description: Parse a name. Next character is put in the accumulator 
%%              if it's a valid name character.
%%              [5] Name ::= (Letter | '_' | ':') (NameChar)*
%%----------------------------------------------------------------------
parse_name(?STRING_EMPTY, State, Acc) ->
    cf(?STRING_EMPTY, State, Acc, fun parse_name/3);
parse_name(?STRING_UNBOUND_REST(C, Rest) = Bytes, State, Acc) ->
    case is_name_char(C) of
	true ->
	    parse_name(Rest, State, [C|Acc]);
	false ->
	    {lists:reverse(Acc), Bytes, State}
    end;
parse_name(Bytes, State, Acc) ->
    unicode_incomplete_check([Bytes, State, Acc, fun parse_name/3], undefined).


%%----------------------------------------------------------------------
%% Function: parse_ns_name(Rest, State, Prefix, Name) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%%           Prefix = string()
%%           Name = string()
%% Output:   Result = {{Prefix, Name}, Rest, State}
%%           Name = string()
%% Description: Parse a namespace name. Next character is put in the 
%%              accumulator if it's a valid name character. 
%%              The difference between this function and parse_name/3 is 
%%              that a colon is interpreted as a separator between the 
%%              namespace prefix and the name.
%%----------------------------------------------------------------------
parse_ns_name(?STRING_EMPTY, State, Prefix, Name) ->
    cf(?STRING_EMPTY, State, Prefix, Name, fun parse_ns_name/4);
parse_ns_name(?STRING_UNBOUND_REST($:, Rest), State, [], Name) ->
    parse_ns_name(Rest, State, lists:reverse(Name), []);
parse_ns_name(?STRING_UNBOUND_REST(C, Rest) = Bytes, State, Prefix, Name) ->
    case is_name_char(C) of
	true ->
	    parse_ns_name(Rest, State, Prefix, [C|Name]);
	false ->
	    {{Prefix,lists:reverse(Name)}, Bytes, State}
    end;
parse_ns_name(Bytes, State, Prefix, Name) ->
    unicode_incomplete_check([Bytes, State, Prefix, Name, fun parse_ns_name/4], 
			     undefined).


%%----------------------------------------------------------------------
%% Function: parse_pi_data(Rest, State, Acc) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%%           Acc = string()
%% Output:   Result = {PiData, Rest, State}
%%           PiData = string()
%% Description: Parse the data part of the processing instruction. 
%%              If next character is valid it's put in the accumulator.
%%----------------------------------------------------------------------
parse_pi_data(?STRING_EMPTY, State, Acc) ->
    cf(?STRING_EMPTY, State, Acc, fun parse_pi_data/3);
parse_pi_data(?STRING("?") = Bytes, State, Acc) ->
    cf(Bytes, State, Acc, fun parse_pi_data/3);
parse_pi_data(?STRING("\r") = Bytes, State, Acc) ->
    cf(Bytes, State, Acc, fun parse_pi_data/3);
parse_pi_data(?STRING_REST("?>", Rest), State, Acc) ->
    {lists:reverse(Acc), Rest, State};
parse_pi_data(?STRING_REST("\n", Rest), #xmerl_sax_parser_state{line_no=N} = State, Acc) ->
    parse_pi_data(Rest, State#xmerl_sax_parser_state{line_no=N+1}, [?lf |Acc]);
parse_pi_data(?STRING_REST("\r\n", Rest), #xmerl_sax_parser_state{line_no=N} = State, Acc) ->
    parse_pi_data(Rest, State#xmerl_sax_parser_state{line_no=N+1}, [?lf |Acc]);
parse_pi_data(?STRING_REST("\r", Rest), #xmerl_sax_parser_state{line_no=N} = State, Acc) ->
    parse_pi_data(Rest, State#xmerl_sax_parser_state{line_no=N+1}, [?lf |Acc]);
parse_pi_data(?STRING_UNBOUND_REST(C, Rest), State, Acc) when ?is_char(C)->
    parse_pi_data(Rest, State, [C|Acc]);
parse_pi_data(Bytes, State, Acc) ->
    unicode_incomplete_check([Bytes, State, Acc, fun parse_pi_data/3], 
			     "not an character").


%%----------------------------------------------------------------------
%% Function: parse_cdata(Rest, State) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%% Output:   Result = {Rest, State}
%% Description: Start the parsing of a CDATA block.
%%              [18] CDSect ::= CDStart CData CDEnd
%%              [19] CDStart ::= '<![CDATA['
%%              [20] CData ::= (Char* - (Char* ']]>' Char*))
%%              [21] CDEnd ::= ']]>'
%%----------------------------------------------------------------------
parse_cdata(?STRING_EMPTY, State) -> 
    cf(?STRING_EMPTY, State, fun parse_cdata/2);
parse_cdata(?STRING("[") = Bytes, State) ->
    cf(Bytes, State, fun parse_cdata/2);
parse_cdata(?STRING("[C") = Bytes, State) ->
    cf(Bytes, State, fun parse_cdata/2);
parse_cdata(?STRING("[CD") = Bytes, State) ->
    cf(Bytes, State, fun parse_cdata/2);
parse_cdata(?STRING("[CDA") = Bytes, State) ->
    cf(Bytes, State, fun parse_cdata/2);
parse_cdata(?STRING("[CDAT") = Bytes, State) ->
    cf(Bytes, State, fun parse_cdata/2);
parse_cdata(?STRING("[CDATA") = Bytes, State) ->
    cf(Bytes, State, fun parse_cdata/2);
parse_cdata(?STRING_REST("[CDATA[", Rest), State) ->
    State1 = event_callback(startCDATA, State),	   
    parse_cdata(Rest, State1, []);
parse_cdata(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_cdata/2],
			     "expecting comment or CDATA").


%%----------------------------------------------------------------------
%% Function: parse_cdata(Rest, State, Acc) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%%           Acc = string()
%% Output:   Result = {Rest, State}
%% Description: Parse a CDATA block.
%%----------------------------------------------------------------------
parse_cdata(?STRING_EMPTY, State, Acc) -> 
    cf(?STRING_EMPTY, State, Acc, fun parse_cdata/3);
parse_cdata(?STRING("\r") = Bytes, State, Acc) -> 
    cf(Bytes, State, Acc, fun parse_cdata/3);
parse_cdata(?STRING("]") = Bytes, State, Acc) -> 
    cf(Bytes, State, Acc, fun parse_cdata/3);
parse_cdata(?STRING("]]") = Bytes, State, Acc) -> 
    cf(Bytes, State, Acc, fun parse_cdata/3);
parse_cdata(?STRING_REST("]]>", Rest), State, Acc) -> 
    State1 = event_callback({characters, lists:reverse(Acc)}, State),   
    State2 = event_callback(endCDATA, State1),	    
    parse_content(Rest, State2, [], true);
parse_cdata(?STRING_REST("\n", Rest), #xmerl_sax_parser_state{line_no=N} = State, Acc) -> 
    parse_cdata(Rest, State#xmerl_sax_parser_state{line_no=N+1}, [?lf |Acc]);
parse_cdata(?STRING_REST("\r\n", Rest), #xmerl_sax_parser_state{line_no=N} = State, Acc) -> 
    parse_cdata(Rest, State#xmerl_sax_parser_state{line_no=N+1}, [?lf |Acc]);
parse_cdata(?STRING_REST("\r", Rest), #xmerl_sax_parser_state{line_no=N} = State, Acc) -> 
    parse_cdata(Rest, State#xmerl_sax_parser_state{line_no=N+1}, [?lf |Acc]);
parse_cdata(?STRING_UNBOUND_REST(C, Rest), State, Acc) when ?is_char(C) -> 
    parse_cdata(Rest, State, [C|Acc]);
parse_cdata(?STRING_UNBOUND_REST(C, _), State, _) -> 
    ?fatal_error(State, "CDATA contains bad character value: " ++ [C]);
parse_cdata(Bytes, State, Acc) ->
    unicode_incomplete_check([Bytes, State, Acc, fun parse_cdata/3], 
			     undefined).


%%----------------------------------------------------------------------
%% Function: parse_comment(Rest, State, Acc) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%%           Acc = string()
%% Output:   Result = {Rest, State}
%% Description: Parse a comment.
%%              [15] Comment ::= '<!--' ((Char - '-') | ('-' (Char - '-')))* '-->'
%%----------------------------------------------------------------------
parse_comment(?STRING_EMPTY, State, Acc) -> 
    cf(?STRING_EMPTY, State, Acc, fun parse_comment/3);
parse_comment(?STRING("\r") = Bytes, State, Acc) -> 
    cf(Bytes, State, Acc, fun parse_comment/3);
parse_comment(?STRING("-") = Bytes, State, Acc) -> 
    cf(Bytes, State, Acc, fun parse_comment/3);
parse_comment(?STRING("--") = Bytes, State, Acc) -> 
    cf(Bytes, State, Acc, fun parse_comment/3);
parse_comment(?STRING_REST("-->", Rest), State, Acc) -> 
    State1 = event_callback({comment, lists:reverse(Acc)}, State),   
    {Rest, State1};
parse_comment(?STRING_REST("--",  _), State, _) -> 
    ?fatal_error(State, "comment contains '--'");
parse_comment(?STRING_REST("\n", Rest), #xmerl_sax_parser_state{line_no=N} = State, Acc) ->
    parse_comment(Rest, State#xmerl_sax_parser_state{line_no=N+1}, [?lf|Acc]);
parse_comment(?STRING_REST("\r\n", Rest), #xmerl_sax_parser_state{line_no=N} = State, Acc) ->
    parse_comment(Rest, State#xmerl_sax_parser_state{line_no=N+1}, [?lf|Acc]);
parse_comment(?STRING_REST("\r", Rest), #xmerl_sax_parser_state{line_no=N} = State, Acc) ->
    parse_comment(Rest, State#xmerl_sax_parser_state{line_no=N+1}, [?lf|Acc]);
parse_comment(?STRING_UNBOUND_REST(C, Rest), State, Acc) ->
    if 
	?is_char(C) ->
	    parse_comment(Rest, State, [C|Acc]);
	true ->
	     ?fatal_error(State, "Bad character in comment: " ++ C)
    end;
parse_comment(Bytes, State, Acc)   -> 
     unicode_incomplete_check([Bytes, State, Acc, fun parse_comment/3], 
			     undefined).


%%----------------------------------------------------------------------
%% Function: parse_misc(Rest, State, Eod) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%%           Eod = true |false
%% Output:   Result = {Rest, State}
%% Description: Parse a misc clause, could be a comment, a processing
%%              instruction or whitespace. If the input stream is empty 
%%              (Eod parameter true) then we return current state and quit.
%%              [27] Misc ::= Comment | PI |  S
%%----------------------------------------------------------------------
parse_misc(?STRING_EMPTY, State, true) ->
    {?STRING_EMPTY, State}; 
parse_misc(?STRING_EMPTY, State, Eod) ->
    cf(?STRING_EMPTY, State, Eod, fun parse_misc/3);
parse_misc(?STRING("<") = Rest, State, Eod) ->
    cf(Rest, State, Eod, fun parse_misc/3);
parse_misc(?STRING_REST("<?", Rest), State, Eod) ->
    case parse_pi(Rest, State) of
	{Rest1, State1} ->
	    parse_misc(Rest1, State1, Eod);
	{endDocument, _Rest1, State1} ->
	    IValue = ?TO_INPUT_FORMAT("<?"),
	    {?APPEND_STRING(IValue, Rest), State1}
    end;
parse_misc(?STRING("<!") = Rest, State, Eod) ->
    cf(Rest, State, Eod, fun parse_misc/3);
parse_misc(?STRING("<!-") = Rest, State, Eod) ->
    cf(Rest, State, Eod, fun parse_misc/3);
parse_misc(?STRING_REST("<!--", Rest), State, Eod) ->
    {Rest1, State1} = parse_comment(Rest, State, []),
    parse_misc(Rest1, State1, Eod);
parse_misc(?STRING_UNBOUND_REST(C, _) = Rest, State, Eod) when ?is_whitespace(C) -> 
    {_WS, Rest1, State1} = whitespace(Rest, State, []),
    parse_misc(Rest1, State1, Eod);
parse_misc(Rest, State, _Eod) ->
    {Rest, State}.
%%    unicode_incomplete_check([Bytes, State, Eod, fun parse_misc/3], 
%%			     "expecting comment or PI").

%%----------------------------------------------------------------------
%% Function: parse_stag(Rest, State) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%% Output:   Result = {Rest, State}
%% Description: Parsing a start tag.
%%              [40] STag ::= '<' Name (S Attribute)* S? '>'
%%----------------------------------------------------------------------
parse_stag(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_stag/2);
parse_stag(?STRING_UNBOUND_REST(C, Rest), State) ->
    case is_name_start(C) of 
	true ->
	    {TagName, Rest1, State1} = 
		parse_ns_name(Rest, State, [], [C]),
	    parse_attributes(Rest1, State1, {TagName, [], []});
	false ->
	    ?fatal_error(State, "expecting name")
    end;
parse_stag(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_stag/2],
			      undefined).

%%----------------------------------------------------------------------
%% Function: parse_attributes(Rest, State, CurrentTag) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%%           CurrentTag = {Name, AttList, NewNsList}
%%           Name = string()
%%           AttList = [{Name, Value}]
%%           NewNsList = [{Name, Value}]
%% Output:   Result = {Rest, State}
%% Description: Parsing the attribute list in the start tag. The current 
%%              tag tuple contains the tag name, a list of attributes 
%%              (exclusive NS attributes) and a list of new NS attributes.
%%              [41] Attribute ::= Name Eq AttValue
%%----------------------------------------------------------------------
parse_attributes(?STRING_EMPTY, State, CurrentTag) ->
    cf(?STRING_EMPTY, State, CurrentTag, fun parse_attributes/3);
parse_attributes(?STRING("/") = Bytes, State, CurrentTag) -> 
    cf(Bytes, State, CurrentTag, fun parse_attributes/3);
parse_attributes(?STRING_REST("/>", Rest), State, {Tag, AttList, NewNsList}) ->
    CompleteNsList =  NewNsList ++ State#xmerl_sax_parser_state.ns,
    {Uri, LocalName, QName, Attributes} = fix_ns(Tag, AttList, CompleteNsList),
    State1 =  send_start_prefix_mapping_event(lists:reverse(NewNsList), State),
    State2 =  event_callback({startElement, Uri, LocalName, QName, Attributes}, State1),
    State3 =  event_callback({endElement, Uri, LocalName, QName}, State2),
    State4 =  send_end_prefix_mapping_event(NewNsList, State3),
    parse_content(Rest, State4, [], true);
parse_attributes(?STRING_REST(">", Rest), #xmerl_sax_parser_state{end_tags=ETags, ns = OldNsList} = State, 
		 {Tag, AttList, NewNsList}) ->
    CompleteNsList =  NewNsList ++ OldNsList,
    {Uri, LocalName, QName, Attributes} = fix_ns(Tag, AttList, CompleteNsList),
    State1 =  send_start_prefix_mapping_event(lists:reverse(NewNsList), State),
    State2 =  event_callback({startElement, Uri, LocalName, QName, Attributes}, State1),
    parse_content(Rest, State2#xmerl_sax_parser_state{end_tags=[{Tag, Uri, LocalName, QName, 
							  OldNsList, NewNsList} |ETags],
					       ns = CompleteNsList}, 
		  [], true);
parse_attributes(?STRING_UNBOUND_REST(C, _) = Rest, State, CurrentTag) when ?is_whitespace(C) ->
    {_WS, Rest1, State1} = whitespace(Rest, State, []),
    parse_attributes(Rest1, State1, CurrentTag);
parse_attributes(?STRING_UNBOUND_REST(C, Rest), State, {Tag, AttList, NsList}) -> 
    case is_name_start(C) of
	true ->
	    {AttrName, Rest1, State1} = 
		parse_ns_name(Rest, State, [], [C]),
	    {Rest2, State2} = parse_eq(Rest1, State1),
	    {AttValue, Rest3, State3} = parse_att_value(Rest2, State2),
	    case AttrName of
		{"xmlns", NsName} ->
		    parse_attributes(Rest3, State3, {Tag, AttList, [{NsName, AttValue} |NsList]});
		{"", "xmlns"} ->
		    parse_attributes(Rest3, State3, {Tag, AttList, [{"", AttValue} |NsList]});
		{_Prefix, _LocalName} ->
		    case lists:keyfind(AttrName, 1, AttList) of
			false ->
			    parse_attributes(Rest3, State3, {Tag, [{AttrName, AttValue}|AttList], NsList});
			_ ->
			    ElName =
				case Tag of
				    {"", N} -> N;
				    {Ns, N} -> Ns ++ ":" ++ N
				end,
			    ?fatal_error(State,  "Attribute exist more than once in element: " ++ ElName)
		    end
	    end;
	false ->
	    ?fatal_error(State,  "Invalid start character in attribute name: " ++ [C])
    end;
parse_attributes(Bytes, State, CurrentTag) ->
    unicode_incomplete_check([Bytes, State, CurrentTag, fun parse_attributes/3],
			      "expecting name, whitespace, /> or >").



%%----------------------------------------------------------------------
%% Function: fix_ns({Prefix, Name}, Attributes, Ns) -> Result
%% Input:    Prefix = string()
%%           Name = string()
%%           Attributes = [{Name, Value}]
%%           Ns = [{Prefix, Uri}]
%%           Uri = string()
%% Output:   Result = {Uri, Name, QualifiedName, Attributes}
%%           QualifiedName = string()
%% Description: Fix the name space prefixing for the attributes and start tag.
%%----------------------------------------------------------------------
% fix_ns({"", Name}, Attributes, Ns) ->
%     Attributes2 = fix_attributes_ns(Attributes, Ns, []),
%     {"", Name, Name, Attributes2};
fix_ns({Prefix, Name}, Attributes, Ns) ->
    Uri = 
	case lists:keysearch(Prefix, 1, Ns) of
	    {value, {Prefix, U}} -> 
		U;
	    false -> 
		""
	end,
    Attributes2 = fix_attributes_ns(Attributes, Ns, []),
 
    {Uri, Name, {Prefix, Name}, Attributes2}.

%%----------------------------------------------------------------------
%% Function: fix_attributes_ns(Attributes, Ns, Acc) -> Result
%% Input:    Attributes = [{{Prefix, Name}, Value}]
%%           Prefix = string()
%%           Name = string()
%%           Value = string()
%%           Ns = [{Prefix, Uri}]
%%           Uri = string()
%% Output:   Result = [{Uri, Name, Value}]
%% Description: Fix the name spaces for the attributes.
%%----------------------------------------------------------------------
fix_attributes_ns([], _, Acc) ->
    Acc;
fix_attributes_ns([{{"", Name}, AttrValue} | Attrs], Ns, Acc) ->
    fix_attributes_ns(Attrs, Ns, [{"", "", Name, AttrValue} |Acc]);
fix_attributes_ns([{{Prefix, Name}, AttrValue} | Attrs], Ns, Acc) ->
    Uri = 
	case lists:keysearch(Prefix, 1, Ns) of
	    {value, {Prefix, U}} -> 
		U;
	    false -> 
		""
	end,    
    fix_attributes_ns(Attrs, Ns, [{Uri, Prefix, Name, AttrValue} |Acc]).
    

%%----------------------------------------------------------------------
%% Function: send_start_prefix_mapping_event(Ns, State) -> Result
%% Input:    Ns = [{Prefix, Uri}]
%%           Prefix = string()
%%           Uri = string()
%%           State = #xmerl_sax_parser_state{}
%% Output:   Result = #xmerl_sax_parser_state{}
%% Description: Loops over a name space list and sends startPrefixMapping events.
%%----------------------------------------------------------------------
send_start_prefix_mapping_event([], State) ->
    State;
send_start_prefix_mapping_event([{Prefix, Uri} |Ns], State) ->
    State1 = event_callback({startPrefixMapping, Prefix, Uri}, State),
    send_start_prefix_mapping_event(Ns, State1).

 
%%----------------------------------------------------------------------
%% Function: send_end_prefix_mapping_event(Ns, State) -> Result
%% Input:    Ns = [{Prefix, Uri}]
%%           Prefix = string()
%%           Uri = string()
%%           State = #xmerl_sax_parser_state{}
%% Output:   Result = #xmerl_sax_parser_state{}
%% Description: Loops over a name space list and sends endPrefixMapping events.
%%----------------------------------------------------------------------
send_end_prefix_mapping_event([], State) ->
    State;
send_end_prefix_mapping_event([{Prefix, _Uri} |Ns], State) ->
    State1 = event_callback({endPrefixMapping, Prefix}, State),
    send_end_prefix_mapping_event(Ns, State1).

   
%%----------------------------------------------------------------------
%% Function: parse_eq(Rest, State) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%% Output:   Result = {Rest, State}
%% Description: Parsing an '=' from the stream.
%%              [25] Eq ::= S? '=' S?
%%----------------------------------------------------------------------
parse_eq(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_eq/2);
parse_eq(?STRING_REST("=", Rest), State) ->
	{Rest, State};
parse_eq(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->	
	{_WS, Rest, State1} = 
		whitespace(Bytes, State, []),
	parse_eq(Rest, State1);
parse_eq(Bytes, State) ->	
    unicode_incomplete_check([Bytes, State, fun parse_eq/2], 
			     "expecting = or whitespace"). 


%%----------------------------------------------------------------------
%% Function: parse_att_value(Rest, State) -> Result
%% Input:    Rest = string() | binary()
%%           State = #xmerl_sax_parser_state{}
%% Output:   Result = {Rest, State}
%% Description: Start the parsing of an attribute value by checking the delimiter
%%              [10] AttValue ::= '"' ([^<&"] | Reference)* '"'
%%              	       |  "'" ([^<&'] | Reference)* "'"
%%----------------------------------------------------------------------
parse_att_value(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_att_value/2);
parse_att_value(?STRING_UNBOUND_REST(C, Rest), State)  when C == $'; C == $"  ->	
	parse_att_value(Rest, State, C, []);
parse_att_value(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->	
	{_WS, Rest, State1} = 
		whitespace(Bytes, State, []),
	parse_att_value(Rest, State1);
parse_att_value(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_att_value/2], 
			     "\', \" or whitespace expected"). 


%%----------------------------------------------------------------------
%% Function  : parse_att_value(Rest, State, Stop, Acc) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Stop = $' | $"
%%             Acc = string()
%% Result    : {Value, Rest, State}
%%             Value = string()
%% Description: Parse an attribute value
%%----------------------------------------------------------------------
parse_att_value(?STRING_EMPTY, State, undefined, Acc) ->
    {Acc, [], State}; %% stop clause when parsing references
parse_att_value(?STRING_EMPTY, State, Stop, Acc) ->
    cf(?STRING_EMPTY, State, Stop, Acc, fun parse_att_value/4);
parse_att_value(?STRING("\r") = Bytes, State, Stop, Acc) ->
    cf(Bytes, State, Stop, Acc, fun parse_att_value/4);
parse_att_value(?STRING_REST("\n", Rest), #xmerl_sax_parser_state{line_no=N} = State, Stop, Acc) -> 
    parse_att_value(Rest, 
		    State#xmerl_sax_parser_state{line_no=N+1}, Stop, [?space |Acc]);
parse_att_value(?STRING_REST("\r\n", Rest), #xmerl_sax_parser_state{line_no=N} = State, Stop, Acc) -> 
    parse_att_value(Rest, 
		    State#xmerl_sax_parser_state{line_no=N+1}, Stop, [?space |Acc]);
parse_att_value(?STRING_REST("\r", Rest), #xmerl_sax_parser_state{line_no=N} = State, Stop, Acc)  -> 
    parse_att_value(Rest, 
		    State#xmerl_sax_parser_state{line_no=N+1}, Stop, [?space |Acc]);
parse_att_value(?STRING_REST("\t", Rest), #xmerl_sax_parser_state{line_no=N} = State, Stop, Acc)  -> 
    parse_att_value(Rest, 
		    State#xmerl_sax_parser_state{line_no=N+1}, Stop, [?space |Acc]);
parse_att_value(?STRING_REST("&", Rest), State, Stop, Acc)  -> 
    {Ref, Rest1, State1} = parse_reference(Rest, State, true),
    case Ref of 
	{character, _, CharValue}  ->
	    parse_att_value(Rest1, State1, Stop, [CharValue | Acc]); 
	{internal_general, true, _, Value} ->
	    parse_att_value(Rest1, State1, Stop, Value ++ Acc);
	{internal_general, false, _, Value} ->
	    {ParsedValue, [], State2} = parse_att_value(?TO_INPUT_FORMAT(Value), State1, undefined, []),
	    parse_att_value(Rest1, State2, Stop, ParsedValue ++ Acc);
	{external_general, Name, _} ->
	    ?fatal_error(State1, "External parsed entity reference in attribute value: " ++ Name);
	{not_found, Name} ->
	    case State#xmerl_sax_parser_state.skip_external_dtd of
		false ->
		    ?fatal_error(State1, "Entity not declared: " ++ Name); %%VC: Entity Declared
		true ->
		    parse_att_value(Rest1, State1, Stop, ";" ++ lists:reverse(Name) ++ "&" ++ Acc)
	    end;
	{unparsed, Name, _}  ->
	    ?fatal_error(State1, "Unparsed entity reference in  attribute value: " ++ Name)
    end;
parse_att_value(?STRING_UNBOUND_REST(Stop, Rest), State, Stop, Acc) ->
    {lists:reverse(Acc), Rest, State};
parse_att_value(?STRING_UNBOUND_REST($<, _Rest), State, _Stop, _Acc)   ->
    ?fatal_error(State,  "< not allowed in attribute value");
parse_att_value(?STRING_UNBOUND_REST(C, Rest), State, Stop, Acc)   ->
    if
	?is_char(C) ->
	    parse_att_value(Rest, State, Stop, [C|Acc]);
	true ->
	     ?fatal_error(State, lists:flatten(io_lib:format("Bad character in attribute value: ~p", [C])))
    end;
parse_att_value(Bytes, State, Stop, Acc)   ->
    unicode_incomplete_check([Bytes, State, Stop, Acc, fun parse_att_value/4],
			     undefined).


%%----------------------------------------------------------------------
%% Function  : parse_etag(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Rest, State}
%% Description: Parse the end tag
%%              [42] ETag ::= '</' Name S? '>'
%%----------------------------------------------------------------------
parse_etag(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_etag/2);
parse_etag(?STRING_UNBOUND_REST(C, Rest), 
	   #xmerl_sax_parser_state{end_tags=[{ETag, _Uri, _LocalName, _QName, _OldNsList, _NewNsList}
				      |_RestOfETags]} = State) ->
    case is_name_start(C) of
	true ->
	    {Tag, Rest1, State1} = parse_ns_name(Rest, State, [], [C]),
	    case Tag == ETag of 
		true ->
		    {_WS, Rest2, State2} = whitespace(Rest1, State1, []),
		    parse_etag_1(Rest2, State2, Tag);
		false ->
		    case State1#xmerl_sax_parser_state.match_end_tags of
			true ->
			    {P,TN} = Tag,
			    ?fatal_error(State1, "EndTag: " ++ P ++ ":" ++ TN ++ 
					 ", does not match StartTag");
			false ->
			    {_WS, Rest2, State2} = whitespace(Rest1, State1, []),
			    parse_etag_1(Rest2, State2, Tag)
		    end
	    end;
	false ->
	    ?fatal_error(State, "Name expected")
    end;
parse_etag(?STRING_UNBOUND_REST(_C, _) = Rest, #xmerl_sax_parser_state{end_tags=[]}= State) ->
    {Rest, State};
parse_etag(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_etag/2], 
			     undefined).


parse_etag_1(?STRING_REST(">", Rest), 
	     #xmerl_sax_parser_state{end_tags=[{_ETag, Uri, LocalName, QName, OldNsList, NewNsList}
					|RestOfETags]} = State, _Tag) ->
    State1 =  event_callback({endElement, Uri, LocalName, QName}, State),
    State2 =  send_end_prefix_mapping_event(NewNsList, State1),
    parse_content(Rest, 
		  State2#xmerl_sax_parser_state{end_tags=RestOfETags,
					 ns = OldNsList},
		  [], true);
parse_etag_1(?STRING_UNBOUND_REST(_C, _), State, Tag) ->
    {P,TN} = Tag,
    ?fatal_error(State, "Bad EndTag: " ++ P ++ ":" ++ TN);
parse_etag_1(Bytes, State, Tag) ->
    unicode_incomplete_check([Bytes, State, Tag, fun parse_etag_1/3], 
			     undefined).
    
%%----------------------------------------------------------------------
%% Function: parse_content(Rest, State, Acc, IgnorableWS) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Acc = string()
%%             IgnorableWS = true | false
%% Result    : {Rest, State}
%% Description: Parsing the content part of tags
%%              [43] content ::= (element | CharData | Reference | CDSect | PI | Comment)*
%%----------------------------------------------------------------------

parse_content(?STRING_EMPTY, State, Acc, IgnorableWS) ->
    case catch cf(?STRING_EMPTY, State, Acc, IgnorableWS, fun parse_content/4) of
	{Rest, State1} when is_record(State1, xmerl_sax_parser_state) ->
	    {Rest, State1};
	{fatal_error, {State1, Msg}} ->
	    case check_if_document_complete(State1, Msg) of
		true ->
		    State2 = send_character_event(length(Acc), IgnorableWS, lists:reverse(Acc), State1),
		    {?STRING_EMPTY, State2};
		false ->
		    ?fatal_error(State1, Msg)
	    end;
	Other ->
	    throw(Other)
    end;
parse_content(?STRING("\r") = Bytes, State, Acc, IgnorableWS) ->
    cf(Bytes, State, Acc, IgnorableWS, fun parse_content/4);
parse_content(?STRING("<") = Bytes, State, Acc, IgnorableWS) ->	
    cf(Bytes, State, Acc, IgnorableWS, fun parse_content/4);
parse_content(?STRING_REST("</", Rest), State, Acc, IgnorableWS) ->
    State1 = send_character_event(length(Acc), IgnorableWS, lists:reverse(Acc), State),
    parse_etag(Rest, State1);
parse_content(?STRING("<!") = Bytes, State, _Acc, IgnorableWS) ->
    cf(Bytes, State, [], IgnorableWS, fun parse_content/4);
parse_content(?STRING("<!-") = Bytes, State, _Acc, IgnorableWS) ->
    cf(Bytes, State, [], IgnorableWS, fun parse_content/4);
parse_content(?STRING_REST("<!--", Rest), State, Acc, IgnorableWS) ->
    State1 = send_character_event(length(Acc), IgnorableWS, lists:reverse(Acc), State),
    {Rest1, State2} = parse_comment(Rest, State1, []),
    parse_content(Rest1, State2, [], true);
parse_content(?STRING_REST("<?", Rest), State, Acc, IgnorableWS) ->
    State1 = send_character_event(length(Acc), IgnorableWS, lists:reverse(Acc), State),
    case parse_pi(Rest, State1) of
	{Rest1, State2} ->
	    parse_content(Rest1, State2, [], true);
	{endDocument, _Rest1, State2} ->
	    IValue = ?TO_INPUT_FORMAT("<?"),
	    {?APPEND_STRING(IValue, Rest), State2}
    end;
parse_content(?STRING_REST("<!", Rest1) = Rest, #xmerl_sax_parser_state{end_tags = ET} = State, Acc, IgnorableWS) ->
    case ET of 
	[] ->
	    {Rest, State}; %%LATH : Skicka ignorable WS ???
	_ ->
	    State1 = send_character_event(length(Acc), IgnorableWS, lists:reverse(Acc), State),
	    parse_cdata(Rest1, State1)
    end;
parse_content(?STRING_REST("<", Rest1) = Rest, #xmerl_sax_parser_state{end_tags = ET} = State, Acc, IgnorableWS) ->
    case ET of 
	[] ->
	    {Rest, State}; %%LATH :  Skicka ignorable WS ???
	_ ->
	    State1 = send_character_event(length(Acc), IgnorableWS, lists:reverse(Acc), State),
	    parse_stag(Rest1, State1)
    end;
parse_content(?STRING_REST("\n", Rest), State, Acc, IgnorableWS) ->
    N = State#xmerl_sax_parser_state.line_no,
    parse_content(Rest, State#xmerl_sax_parser_state{line_no=N+1},[?lf |Acc], IgnorableWS);
parse_content(?STRING_REST("\r\n", Rest), State, Acc, IgnorableWS) ->
    N = State#xmerl_sax_parser_state.line_no,
    parse_content(Rest, State#xmerl_sax_parser_state{line_no=N+1},[?lf |Acc], IgnorableWS);
parse_content(?STRING_REST("\r", Rest), State, Acc, IgnorableWS) ->
    N = State#xmerl_sax_parser_state.line_no,
    parse_content(Rest, State#xmerl_sax_parser_state{line_no=N+1},[?lf |Acc], IgnorableWS);
parse_content(?STRING_REST(" ", Rest), State, Acc, IgnorableWS) ->
    parse_content(Rest, State,[?space |Acc], IgnorableWS);
parse_content(?STRING_REST("\t", Rest), State, Acc, IgnorableWS) ->
    parse_content(Rest, State,[?tab |Acc], IgnorableWS);
parse_content(?STRING_REST("]]>", _Rest), State, _Acc, _IgnorableWS) ->
    ?fatal_error(State, "\"]]>\" is not allowed in content");
parse_content(?STRING_UNBOUND_REST(_C, _) = Rest, 
	      #xmerl_sax_parser_state{end_tags = []} = State, 
	      _Acc, _IgnorableWS) ->
    {Rest, State};
parse_content(?STRING_REST("&", Rest), State, Acc, _IgnorableWS) ->
    {Ref, Rest1, State1} = parse_reference(Rest, State, true),
    case Ref of 
	{character, _, CharValue}  ->
	    parse_content(Rest1, State1, [CharValue | Acc], false);
	{internal_general, true, _, Value} ->
	    parse_content(Rest1, State1, Value ++ Acc, false);
	{internal_general, false, _, Value} ->
	    IValue = ?TO_INPUT_FORMAT(Value),
	    parse_content(?APPEND_STRING(IValue, Rest1), State1, Acc, false);     
	{external_general, _, {PubId, SysId}} ->
	    State2 = parse_external_entity(State1, PubId, SysId),
	    parse_content(Rest1, State2, Acc, false);
	{not_found, Name} ->
	    case State#xmerl_sax_parser_state.skip_external_dtd of
		false ->
		    ?fatal_error(State1, "Entity not declared: " ++ Name); %%VC: Entity Declared
		true ->
		    parse_content(Rest1, State1, ";" ++ lists:reverse(Name) ++ "&" ++ Acc, false)
	    end;
	{unparsed, Name, _}  ->
	    ?fatal_error(State1, "Unparsed entity reference in content: " ++ Name)
    end;
parse_content(?STRING_UNBOUND_REST(C, Rest), State, Acc, _IgnorableWS) ->
    if 
	?is_char(C) ->
	    parse_content(Rest, State, [C|Acc], false);
	true ->
	     ?fatal_error(State, lists:flatten(io_lib:format("Bad character in content: ~p", [C])))
    end;
parse_content(Bytes, State, Acc, IgnorableWS)   ->
    unicode_incomplete_check([Bytes, State, Acc, IgnorableWS, fun parse_content/4],
			     undefined).


%%----------------------------------------------------------------------
%% Function: check_if_document_complete(State, ErrorMsg) -> Result
%% Parameters: State = #xmerl_sax_parser_state{}
%%             ErrorMsg = string()
%% Result    : boolean()
%% Description: Checks that the document is complete if we don't have more data..
%%----------------------------------------------------------------------
check_if_document_complete(#xmerl_sax_parser_state{end_tags = []}, 
			    "No more bytes") ->
    true;
check_if_document_complete(#xmerl_sax_parser_state{end_tags = []}, 
			    "Continuation function undefined") ->
    true;
check_if_document_complete(_, _) ->
    false.

%%----------------------------------------------------------------------
%% Function: send_character_event(Length, IgnorableWS, String, State) -> Result
%% Parameters: Length = integer()
%%             IgnorableWS = true | false
%%             String = string()
%%             State = #xmerl_sax_parser_state{}
%% Result    : #xmerl_sax_parser_state{}
%% Description: Sends the correct type of character event depending on if
%%              it's whitespaces that can be ignored or not.
%%----------------------------------------------------------------------
send_character_event(0, _, _, State) ->
    State;
send_character_event(_, false, String, State) ->
    event_callback({characters, String}, State);
send_character_event(_, true, String, State) ->
    event_callback({ignorableWhitespace, String}, State).


%%----------------------------------------------------------------------
%% Function: whitespace(Rest, State, Acc) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Acc = string()
%% Result    : {Rest, State}
%% Description: Parse whitespaces.
%%              [3] S ::= (#x20 | #x9 | #xD | #xA)+
%%----------------------------------------------------------------------
whitespace(?STRING_EMPTY, State, Acc) ->  
    case cf(?STRING_EMPTY, State, Acc, fun whitespace/3) of
	{?STRING_EMPTY, State} ->
	    {lists:reverse(Acc), ?STRING_EMPTY, State};
	Ret ->
	    Ret
    end;
whitespace(?STRING("\r") = Bytes, State, Acc) -> 
    case cf(Bytes, State, Acc, fun whitespace/3) of
	{?STRING("\r") = Bytes, State} ->
	    {lists:reverse(Acc), Bytes, State}; 
	Ret ->
	    Ret
    end;
whitespace(?STRING_REST("\n", Rest), State, Acc) -> 
    N = State#xmerl_sax_parser_state.line_no,
    whitespace(Rest, State#xmerl_sax_parser_state{line_no=N+1}, [?lf |Acc]);
whitespace(?STRING_REST("\r\n", Rest), State, Acc) -> 
    N = State#xmerl_sax_parser_state.line_no,
    whitespace(Rest, State#xmerl_sax_parser_state{line_no=N+1}, [?lf |Acc]);
whitespace(?STRING_REST("\r", Rest), State, Acc) -> 
    N = State#xmerl_sax_parser_state.line_no,
    whitespace(Rest, State#xmerl_sax_parser_state{line_no=N+1}, [?lf |Acc]);
whitespace(?STRING_UNBOUND_REST(C, Rest), State, Acc) when ?is_whitespace(C) -> 
    whitespace(Rest, State, [C|Acc]);
whitespace(?STRING_UNBOUND_REST(_C, _) = Bytes, State, Acc) -> 
    {lists:reverse(Acc), Bytes, State};
whitespace(Bytes, #xmerl_sax_parser_state{encoding=Enc} = State, Acc) when is_binary(Bytes) -> 
    case unicode:characters_to_list(Bytes, Enc) of 
	{incomplete, _, _} ->
	    cf(Bytes, State, Acc, fun whitespace/3);
	{error, _Encoded, _Rest} ->
	    ?fatal_error(State, lists:flatten(io_lib:format("Bad character, not in ~p\n", [Enc])))
    end.


%%----------------------------------------------------------------------
%% Function: parse_reference(Rest, State, HaveToExist) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Value, Rest, State}
%% Description: Parse entity references.
%%              [66] CharRef ::= '&#' [0-9]+ ';'
%%              	       | '&#x' [0-9a-fA-F]+ ';'
%%              [67] Reference ::= EntityRef | CharRef
%%              [68] EntityRef ::= '&' Name ';'
%%----------------------------------------------------------------------
parse_reference(?STRING_EMPTY, State, HaveToExist) ->
    cf(?STRING_EMPTY, State, HaveToExist, fun parse_reference/3);
parse_reference(?STRING("#") = Bytes, State, HaveToExist) -> 
    cf(Bytes, State, HaveToExist, fun parse_reference/3);
parse_reference(?STRING_REST("#x", Rest), State, _HaveToExist) ->
    {CharValue, RefString, Rest1, State1} = parse_hex(Rest, State, []),
    if 
	?is_char(CharValue) ->
	    {{character, is_delimiter(CharValue), CharValue},
	     Rest1, State1};
	true ->
	    ?fatal_error(State1, "Not a legal character: #x" ++ RefString) %%WFC: Legal Character
    end;
parse_reference(?STRING_REST("#", Rest), State, _HaveToExist) ->
    {CharValue, RefString, Rest1, State1} = parse_digit(Rest, State, []),
    if 
	?is_char(CharValue) ->
	    {{character, is_delimiter(CharValue), CharValue},
	     Rest1, State1};
	true ->
	    ?fatal_error(State1, "Not a legal character: #" ++ RefString)%%WFC: Legal Character
    end;
parse_reference(?STRING_UNBOUND_REST(C, Rest), State, HaveToExist) ->
    case is_name_start(C) of
	true ->
	    {Name, Rest1, State1} = parse_name(Rest, State, [C]),
	    parse_reference_1(Rest1, State1, HaveToExist, Name);
	false -> 
	    ?fatal_error(State, "name expected")
    end;
parse_reference(Bytes, State, HaveToExist) ->
    unicode_incomplete_check([Bytes, State, HaveToExist, fun parse_reference/3], 
			     underfined).


parse_reference_1(?STRING_REST(";", Rest), State, HaveToExist, Name) ->
    case look_up_reference(Name, HaveToExist, State) of
	{internal_general, Name, RefValue} ->
	    {{internal_general, is_delimiter(RefValue), Name, RefValue}, 
	     Rest, State};
	Result ->
	    {Result, Rest, State}
    end;
parse_reference_1(Bytes, State, HaveToExist, Name) ->
    unicode_incomplete_check([Bytes, State, HaveToExist, Name, fun parse_reference_1/4], 
			     "Missing semicolon after reference: " ++ Name).



%%----------------------------------------------------------------------
%% Function: is_delimiter(Character) -> Result
%% Parameters: Character
%% Result    :
%%----------------------------------------------------------------------
is_delimiter(38) ->
     true;
is_delimiter(60) -> 
     true;
is_delimiter(62) ->
     true;
is_delimiter(39) ->
     true;
is_delimiter(34) ->
     true;
is_delimiter("&") ->
     true;
is_delimiter("<") ->
     true;
is_delimiter(">") ->
     true;
is_delimiter("'") ->
     true;
is_delimiter("\"") ->
     true;
is_delimiter(_) ->
     false.

%%----------------------------------------------------------------------
%% Function: parse_pe_reference(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Acc = string()
%% Result    : {Result, Rest, State}
%% Description: Parse a parameter entity reference.
%%              [69] PEReference ::= '%' Name ';'
%%----------------------------------------------------------------------
parse_pe_reference(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_pe_reference/2);
parse_pe_reference(?STRING_UNBOUND_REST(C, Rest), State) ->
    case is_name_start(C) of
	true ->
	    {Name, Rest1, State1} = parse_name(Rest, State, [C]),
	    parse_pe_reference_1(Rest1, State1, Name);
	false -> 
	    ?fatal_error(State, "Name expected") 
    end;
parse_pe_reference(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_pe_reference/2], 
			     underfined).


parse_pe_reference_1(?STRING_REST(";", Rest), State, Name) ->
    Name1 = "%" ++ Name,
    Result = look_up_reference(Name1, true, State),
    {Result, Rest, State};
parse_pe_reference_1(Bytes, State, Name) ->
    unicode_incomplete_check([Bytes, State, Name, fun parse_pe_reference_1/3], 
			     "missing ; after reference " ++ Name).



%%----------------------------------------------------------------------
%% Function: insert_reference(Reference, State) -> Result
%% Parameters: Reference = string()
%%             State = #xmerl_sax_parser_state{}
%% Result    :
%%----------------------------------------------------------------------
insert_reference({Name, Type, Value}, Table) ->
    case ets:lookup(Table, Name) of
	[{Name, _, _}] ->
	    ok;
	_ ->
	    ets:insert(Table, {Name, Type, Value})
    end.
	    


%%----------------------------------------------------------------------
%% Function: look_up_reference(Reference, State) -> Result
%% Parameters: Reference = string()
%%             State = #xmerl_sax_parser_state{}
%% Result    :
%%----------------------------------------------------------------------
look_up_reference("amp", _, _) ->
    {internal_general, "amp", "&"};
look_up_reference("lt", _, _) ->
    {internal_general, "lt", "<"};
look_up_reference("gt", _, _) ->
    {internal_general, "gt", ">"};
look_up_reference("apos", _, _) ->
    {internal_general, "apos", "'"};
look_up_reference("quot", _, _) ->
    {internal_general, "quot", "\""};
look_up_reference(Name, HaveToExist, State) ->
    case ets:lookup(State#xmerl_sax_parser_state.ref_table, Name) of
	[{Name, Type, Value}] ->
	    {Type, Name, Value};
	_ ->
	    case HaveToExist of
		true ->
		    case State#xmerl_sax_parser_state.standalone of
			yes ->
			    ?fatal_error(State, "Entity not declared: " ++ Name); %%WFC: Entity Declared 
			no ->
			    {not_found, Name}  %%VC: Entity Declared
		    end;
		false ->
		    {not_found, Name}
	    end
    end.


%%----------------------------------------------------------------------
%% Function: parse_hex(Rest, State, Acc) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Acc = string()
%% Result    : {Value, Reference, Rest, State}
%%             Value = integer()
%%             Reference = string()
%% Description: Parse a hex reference.
%%----------------------------------------------------------------------
parse_hex(?STRING_EMPTY, State, Acc) ->
    cf(?STRING_EMPTY, State, Acc, fun parse_hex/3);
parse_hex(?STRING_REST(";", Rest), State, Acc) ->
    RefString = lists:reverse(Acc),
    {erlang:list_to_integer(RefString, 16), RefString, Rest, State};
parse_hex(?STRING_UNBOUND_REST(C, Rest), State, Acc) when ?is_hex_digit(C) ->
    parse_hex(Rest, State, [C |Acc]);
parse_hex(Bytes, State, Acc) ->
    unicode_incomplete_check([Bytes, State, Acc, fun parse_hex/3],
			     "Bad hex value in reference: "). 


%%----------------------------------------------------------------------
%% Function: parse_digit(Rest, State, Acc) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Acc = string()
%% Result    : {Value, Reference, Rest, State}
%%             Value = integer()
%%             Reference = string()
%% Description: Parse a decimal reference.
%%----------------------------------------------------------------------
parse_digit(?STRING_EMPTY, State, Acc) ->
    cf(?STRING_EMPTY, State, Acc, fun parse_digit/3);
parse_digit(?STRING_REST(";", Rest), State, Acc) ->
    RefString = lists:reverse(Acc),
    {list_to_integer(RefString), RefString, Rest, State};
parse_digit(?STRING_UNBOUND_REST(C, Rest), State, Acc) ->
    case is_digit(C) of
	true ->
	    parse_digit(Rest, State, [C |Acc]);
	false ->
	    ?fatal_error(State, "Character in reference not a digit: " ++ [C])
    end;
parse_digit(Bytes, State, Acc) ->
    unicode_incomplete_check([Bytes, State, Acc, fun parse_digit/3], 
			     undefined).

%%----------------------------------------------------------------------
%% Function: parse_system_litteral(Rest, State, Stop, Acc) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Stop = $' | $"
%%             Acc = string()
%% Result    : {Value, Reference, Rest, State}
%%             Value = integer()
%%             Reference = string()
%% Description: Parse a system litteral.
%%              [11] SystemLiteral ::= ('"' [^"]* '"') | ("'" [^']* "'")
%%----------------------------------------------------------------------
parse_system_litteral(?STRING_EMPTY, State, Stop, Acc) ->
    cf(?STRING_EMPTY, State, Stop, Acc, fun parse_system_litteral/4);
parse_system_litteral(?STRING_UNBOUND_REST(Stop, Rest), State, Stop, Acc) ->
    {lists:reverse(Acc), Rest, State};
parse_system_litteral(?STRING_UNBOUND_REST(C, Rest), State, Stop, Acc) ->
   parse_system_litteral(Rest, State, Stop, [C |Acc]);
parse_system_litteral(Bytes, State, Stop, Acc) ->
    unicode_incomplete_check([Bytes, State, Stop, Acc, fun parse_system_litteral/4], 
			     undefined).

%%----------------------------------------------------------------------
%% Function: parse_pubid_litteral(Rest, State, Stop, Acc) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Stop = $' | $"
%%             Acc = string()
%% Result    : {Value, Reference, Rest, State}
%%             Value = integer()
%%             Reference = string()
%% Description: Parse a public idlitteral.
%%              [12] PubidLiteral ::= '"' PubidChar* '"' | "'" (PubidChar - "'")* "'"
%%----------------------------------------------------------------------
parse_pubid_litteral(?STRING_EMPTY, State, Stop, Acc) ->
    cf(?STRING_EMPTY, State, Stop, Acc, fun parse_pubid_litteral/4);
parse_pubid_litteral(?STRING_UNBOUND_REST(Stop, Rest), State, Stop, Acc) ->
    {lists:reverse(Acc), Rest, State};
parse_pubid_litteral(?STRING_UNBOUND_REST(C, Rest), State, Stop, Acc) ->
    case is_pubid_char(C) of
	true ->
	    parse_pubid_litteral(Rest, State, Stop, [C |Acc]);
	false ->
	    ?fatal_error(State, "Character not allowed in pubid litteral: " ++ [C])
    end;
parse_pubid_litteral(Bytes, State, Stop, Acc) ->
    unicode_incomplete_check([Bytes, State, Stop, Acc, fun parse_pubid_litteral/4], 
			     undefined).

%%======================================================================
%% DTD Parsing
%%======================================================================

%%----------------------------------------------------------------------
%% Function  : parse_doctype(Rest, State, Level, Acc) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Level = integer()
%%             Acc = string()
%% Result    : {string(), Rest, State}
%% Description: This function is just searching the end of the doctype 
%%              declaration and doesn't parse it. It's used when the 
%%              parse_dtd option is set to skip.
%%----------------------------------------------------------------------
%% Just returns doctype as string
%% parse_doctype(?STRING_EMPTY, State, Level, Acc) ->
%%     cf(?STRING_EMPTY, State, Level, Acc, fun parse_doctype/4);
%% parse_doctype(?STRING("\r"), State, Level, Acc) ->
%%     cf(?STRING("\r"), State, Level, Acc, fun parse_doctype/4);
%% parse_doctype(?STRING_REST(">", Rest), State, 0, Acc) ->
%%     {Acc, Rest, State};
%% parse_doctype(?STRING_REST(">", Rest), State, Level, Acc) ->
%%     parse_doctype(Rest, State, Level-1, Acc);
%% parse_doctype(?STRING_REST("<", Rest), State, Level, Acc) ->
%%     parse_doctype(Rest, State, Level+1, [$<|Acc]);
%% parse_doctype(?STRING_REST("\n", Rest), #xmerl_sax_parser_state{line_no=N} = State, Level, Acc) ->
%%     parse_doctype(Rest, State#xmerl_sax_parser_state{line_no=N+1}, Level, [?lf |Acc]);
%% parse_doctype(?STRING_REST("\r\n", Rest), #xmerl_sax_parser_state{line_no=N} = State, Level, Acc) ->
%%     parse_doctype(Rest, State#xmerl_sax_parser_state{line_no=N+1}, Level, [?lf |Acc]);
%% parse_doctype(?STRING_REST("\r", Rest), #xmerl_sax_parser_state{line_no=N} = State, Level, Acc) ->
%%     parse_doctype(Rest, State#xmerl_sax_parser_state{line_no=N+1}, Level, [?lf |Acc]);
%% parse_doctype(?STRING_UNBOUND_REST(C, Rest), State, Level, Acc) ->
%%     parse_doctype(Rest, State, Level, [C|Acc]);
%% parse_doctype(Bytes, State, Level, Acc) ->
%%     unicode_incomplete_check([Bytes, State, Level, Acc, fun parse_doctype/4], 
%% 			     undefined).
    

%%----------------------------------------------------------------------
%% Function  : parse_doctype(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Rest, State}
%% Description: This function starts an parsing of the DTD
%%              that sends apropriate events. 
%%              [28] doctypedecl ::= '<!DOCTYPE' S Name (S ExternalID)? S? 
%%                          ('[' (markupdecl | PEReference | S)* ']' S?)? '>'
%%----------------------------------------------------------------------
parse_doctype(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_doctype/2);
parse_doctype(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->
    {_WS, Rest, State1} = whitespace(Bytes, State, []),
    parse_doctype(Rest, State1);
parse_doctype(?STRING_UNBOUND_REST(C, Rest), State) ->
    case is_name_start(C) of
	true ->
	    {Name, Rest1, State1} = parse_name(Rest, State, [C]),
	    parse_doctype_1(Rest1, State1, Name, false);
	false ->
	    ?fatal_error(State, "expecting name or whitespace")
    end;
parse_doctype(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_doctype/2], 
			     undefined).


%%----------------------------------------------------------------------
%% Function  : parse_doctype_1(Rest, State, Name, Definition) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Name = string()
%%             Definition = true |false
%% Result    : {Rest, State}
%% Description: Gets the DTD name as a parameter and contine parse the DOCTYPE
%%              directive
%%----------------------------------------------------------------------
parse_doctype_1(?STRING_EMPTY, State, Name, Definition) ->
    cf(?STRING_EMPTY, State, Name, Definition, fun parse_doctype_1/4);
parse_doctype_1(?STRING_REST(">", Rest), State, _, _) ->
    {Rest, State};
parse_doctype_1(?STRING_REST("[", Rest), State, Name, Definition) ->
    State1 = 
	case Definition of
	    false ->
		event_callback({startDTD, Name, "", ""}, State);
	    true ->
		State
	end,	    
    {Rest1, State2} = parse_doctype_decl(Rest, State1),
    {_WS, Rest2, State3} = whitespace(Rest1, State2, []),
    parse_doctype_2(Rest2, State3);
parse_doctype_1(?STRING_UNBOUND_REST(C, _) = Rest, State, Name, Definition) when ?is_whitespace(C) ->
    {_WS, Rest1, State1} = whitespace(Rest, State, []),
    parse_doctype_1(Rest1, State1, Name, Definition);
parse_doctype_1(?STRING_UNBOUND_REST(C, _) = Rest, State, Name, _Definition) when C == $S; C == $P ->
    {PubId, SysId, Rest1, State1} = parse_external_id(Rest, State, false),
    State2 = event_callback({startDTD, Name, PubId, SysId}, State1),
    State3 = 
	case State2#xmerl_sax_parser_state.skip_external_dtd of 
	    false -> 
		parse_external_entity(State2#xmerl_sax_parser_state{file_type=dtd}, PubId, SysId);
	    true ->
		State2
	end,
    parse_doctype_1(Rest1, State3, Name, true);
parse_doctype_1(Bytes, State, Name, Definition) ->
    unicode_incomplete_check([Bytes, State, Name, Definition, fun parse_doctype_1/4], 
			     "expecting >, external id or declaration part").


parse_doctype_2(?STRING_REST(">", Rest), State) -> 
    {Rest, State};
parse_doctype_2(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_doctype_2/2], 
			     "expecting >").


%%----------------------------------------------------------------------
%% Function  : parse_external_entity(State, PubId, SysId) -> Result
%% Parameters: State = #xmerl_sax_parser_state{}
%%             PubId = string()
%%             SysId = string()
%% Result    : {Rest, State}
%% Description: Starts the parsing of an external entity by calling the resolver and 
%%              then sends the input to the parsing function. 
%%----------------------------------------------------------------------
%% The public id is not handled
parse_external_entity(State, _PubId, SysId) -> 
    
    ExtRef = check_uri(SysId, State#xmerl_sax_parser_state.current_location),
    
    SaveState =  event_callback({startEntity, SysId}, State),

    State1 = State#xmerl_sax_parser_state{line_no=1, 
					  continuation_state=undefined, 
					  continuation_fun=fun xmerl_sax_parser:default_continuation_cb/1,
					  end_tags = []},
    
    
    EventState = handle_external_entity(ExtRef, State1),

    NewState =  event_callback({endEntity, SysId}, SaveState#xmerl_sax_parser_state{event_state=EventState}),
    NewState#xmerl_sax_parser_state{file_type=normal}.



%%----------------------------------------------------------------------
%% Function  : handle_external_entity(ExtRef, State) -> Result
%% Parameters: ExtRef = {file, string()} | {http, string()}
%%             State = #xmerl_sax_parser_state{}
%% Result    : string() | binary()
%% Description: Returns working directory, entity and the opened
%%              filedescriptor.
%%----------------------------------------------------------------------
handle_external_entity({file, FileToOpen}, State) ->

    case file:open(FileToOpen, [raw, read, binary])  of
        {error, Reason} ->
	    ?fatal_error(State, "Couldn't open external entity "++ FileToOpen ++ " : " 
			 ++ file:format_error(Reason));
        {ok, FD} ->
	    {?STRING_EMPTY, EntityState} = 
		parse_external_entity_1(<<>>, 
					State#xmerl_sax_parser_state{continuation_state=FD,
								     current_location=filename:dirname(FileToOpen),
								     entity=filename:basename(FileToOpen),
								     input_type=file}),
	    file:close(FD),
	    EntityState#xmerl_sax_parser_state.event_state
    end;
handle_external_entity({http, Url}, State) ->

    try
	{Host, Port, Key} = http(Url),
	TmpFile = http_get_file(Host, Port, Key),
	case file:open(TmpFile, [raw, read, binary])  of
	    {error, Reason} ->
		?fatal_error(State, "Couldn't open temporary file " ++ TmpFile ++ " : " 
		       ++ file:format_error(Reason));
	    {ok, FD} ->
		{?STRING_EMPTY, EntityState} = 
		    parse_external_entity_1(<<>>, 
					    State#xmerl_sax_parser_state{continuation_state=FD,
									 current_location=filename:dirname(Url),
									 entity=filename:basename(Url),
									 input_type=file}),
		file:close(FD),
		file:delete(TmpFile),
		EntityState#xmerl_sax_parser_state.event_state
	end
    catch
	throw:{error, Error} -> 	    
	    ?fatal_error(State, Error)
    end;
handle_external_entity({Tag, _Url}, State) ->
    ?fatal_error(State, "Unsupported URI type: " ++ atom_to_list(Tag)).

%%----------------------------------------------------------------------
%% Function  : parse_external_entity_1(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Rest, State}
%% Description: Parse the external entity.
%%----------------------------------------------------------------------
parse_external_entity_1(?STRING_EMPTY, #xmerl_sax_parser_state{file_type=Type} = State) ->
    case catch cf(?STRING_EMPTY, State, fun parse_external_entity_1/2) of
	{Rest, State1} when is_record(State1, xmerl_sax_parser_state) ->
	    {Rest, State};
	{fatal_error, {State1, "No more bytes"}} when Type == dtd; Type == entity ->
	    {?STRING_EMPTY, State1};
	Other ->
	    throw(Other)
    end;	
parse_external_entity_1(?BYTE_ORDER_MARK_1, State) ->
    cf(?BYTE_ORDER_MARK_1, State, fun parse_external_entity_1/2);
parse_external_entity_1(?BYTE_ORDER_MARK_2, State) ->
    cf(?BYTE_ORDER_MARK_2, State, fun parse_external_entity_1/2);
parse_external_entity_1(?BYTE_ORDER_MARK_REST(Rest), State) ->
    parse_external_entity_1(Rest, State);
parse_external_entity_1(?STRING("<") = Bytes, State) ->
    cf(Bytes, State, fun parse_external_entity_1/2);
parse_external_entity_1(?STRING("<?") = Bytes, State) ->
    cf(Bytes, State, fun parse_external_entity_1/2);
parse_external_entity_1(?STRING("<?x") = Bytes, State) ->
    cf(Bytes, State, fun parse_external_entity_1/2);
parse_external_entity_1(?STRING("<?xm") = Bytes, State) ->
    cf(Bytes, State, fun parse_external_entity_1/2);
parse_external_entity_1(?STRING("<?xml") = Bytes, State) ->
    cf(Bytes, State, fun parse_external_entity_1/2);
parse_external_entity_1(?STRING_REST("<?xml", Rest) = Bytes, 
			#xmerl_sax_parser_state{file_type=Type} = State) ->   
    {Rest1, State1} = 
	case is_next_char_whitespace(Rest, State) of
	    false ->
		{Bytes, State};
	    true ->
		{_XmlAttributes, R, S} = parse_version_info(Rest, State, []),
		%S1 =  event_callback({processingInstruction, "xml", XmlAttributes}, S),% The XML decl. should not be reported as a PI
		{R, S}
	end,
    case Type of
	dtd -> 
	    case catch parse_doctype_decl(Rest1, State1)  of
		{Rest2, State2} when is_record(State2, xmerl_sax_parser_state) ->
		    {Rest2, State2};
		{fatal_error, {State2, "No more bytes"}} ->
		    {?STRING_EMPTY, State2};
		Other ->
		    throw(Other)
	    end;

	_ -> % Type is normal or entity
	    parse_content(Rest1, State1, [], true)
    end;
parse_external_entity_1(?STRING_UNBOUND_REST(_C, _) = Bytes, 
			#xmerl_sax_parser_state{file_type=Type} = State) ->  
    case Type of
	normal ->
	    parse_content(Bytes, State, [], true);
	dtd ->
	    parse_doctype_decl(Bytes, State);
	entity ->
	    parse_doctype_decl(Bytes, State)    end;
parse_external_entity_1(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_external_entity_1/2], 
			     undefined).

%%----------------------------------------------------------------------
%% Function  : is_next_char_whitespace(Bytes, State) -> Result
%% Parameters: Bytes = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : true | false
%% Description: Checks if first character is whitespace.
%%----------------------------------------------------------------------
is_next_char_whitespace(?STRING_UNBOUND_REST(C, _), _) when ?is_whitespace(C) -> 
    true;
is_next_char_whitespace(?STRING_UNBOUND_REST(_C, _), _) -> 
    false;
is_next_char_whitespace(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun is_next_char_whitespace/2], 
			     undefined).

%%----------------------------------------------------------------------
%% Function  : parse_external_id(Rest, State, OptionalSystemId) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             OptionalSystemId = true | false
%% Result    : {PubId, SysId, Rest, State}
%%             PubId = string()
%%             SysId = string()
%% Description: Parse an external id. The function is used in two cases one
%%              where the system is optional and one where it's required
%%              after a public id.
%%              [75] ExternalID ::= 'SYSTEM' S SystemLiteral
%%             		          | 'PUBLIC' S PubidLiteral S SystemLiteral 
%%----------------------------------------------------------------------
parse_external_id(?STRING_EMPTY, State, OptionalSystemId) ->
    cf(?STRING_EMPTY, State, OptionalSystemId, fun parse_external_id/3);
parse_external_id(?STRING("S") = Bytes, State,OptionalSystemId) ->
    cf(Bytes, State, OptionalSystemId, fun parse_external_id/3);
parse_external_id(?STRING("SY") = Bytes, State, OptionalSystemId) ->
    cf(Bytes, State, OptionalSystemId, fun parse_external_id/3);
parse_external_id(?STRING("SYS") = Bytes, State, OptionalSystemId) ->
    cf(Bytes, State, OptionalSystemId, fun parse_external_id/3);
parse_external_id(?STRING("SYST") = Bytes, State, OptionalSystemId) ->
    cf(Bytes, State, OptionalSystemId, fun parse_external_id/3);
parse_external_id(?STRING("SYSTE") = Bytes, State, OptionalSystemId) ->
    cf(Bytes, State, OptionalSystemId, fun parse_external_id/3);
parse_external_id(?STRING_REST("SYSTEM", Rest), State, _) ->
    {SysId, Rest1, State1} = parse_system_id(Rest, State, false),
    {"", SysId, Rest1, State1};
parse_external_id(?STRING("P") = Bytes, State, OptionalSystemId) ->
    cf(Bytes, State, OptionalSystemId, fun parse_external_id/3);
parse_external_id(?STRING("PU") = Bytes, State, OptionalSystemId) ->
    cf(Bytes, State, OptionalSystemId, fun parse_external_id/3);
parse_external_id(?STRING("PUB") = Bytes, State, OptionalSystemId) ->
    cf(Bytes, State, OptionalSystemId, fun parse_external_id/3);
parse_external_id(?STRING("PUBL") = Bytes, State, OptionalSystemId) ->
    cf(Bytes, State, OptionalSystemId, fun parse_external_id/3);
parse_external_id(?STRING("PUBLI") = Bytes, State, OptionalSystemId) ->
    cf(Bytes, State, OptionalSystemId, fun parse_external_id/3);
parse_external_id(?STRING_REST("PUBLIC", Rest), State, OptionalSystemId) ->
    parse_public_id(Rest, State, OptionalSystemId);
parse_external_id(Bytes, State, OptionalSystemId) ->
    unicode_incomplete_check([Bytes, State, OptionalSystemId, fun parse_external_id/3], 
			     "expecting SYSTEM or PUBLIC").


%%----------------------------------------------------------------------
%% Function  : parse_system_id(Rest, State, OptionalSystemId) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             OptionalSystemId = true | false
%% Result    : {SysId, Rest, State}
%%             SysId = string()
%% Description: Parse a system id. The function is used in two cases one
%%              where the system is optional and one where it's required.
%%----------------------------------------------------------------------
parse_system_id(?STRING_UNBOUND_REST(C, _) = Bytes, State, OptionalSystemId) when ?is_whitespace(C) ->
    {_WS, Rest, State1} = whitespace(Bytes, State, []),
    check_system_litteral(Rest, State1, OptionalSystemId);
parse_system_id(?STRING_UNBOUND_REST(_C, _) = Bytes, State, true) ->
    {"", Bytes, State};
parse_system_id(Bytes, State, OptionalSystemId) ->
    unicode_incomplete_check([Bytes, State, OptionalSystemId, fun parse_system_id/3], 
			     "whitespace expected").

check_system_litteral(?STRING_UNBOUND_REST(C, Rest), State, _OptionalSystemId) when C == $'; C == $" ->
    parse_system_litteral(Rest, State, C, []);
check_system_litteral(?STRING_UNBOUND_REST(_C, _) = Bytes, State, true) ->
    {"", Bytes, State};
check_system_litteral(Bytes, State, OptionalSystemId) ->
    unicode_incomplete_check([Bytes, State, OptionalSystemId, fun check_system_litteral/3], 
			     "\" or \' expected").


%%----------------------------------------------------------------------
%% Function  : parse_public_id(Rest, State, OptionalSystemId) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             OptionalSystemId = true | false
%% Result    : {PubId, SysId, Rest, State}
%%             PubId = string()
%%             SysId = string()
%% Description: Parse a public id. The function is used in two cases one
%%              where the following system is optional and one where it's required.
%%----------------------------------------------------------------------
parse_public_id(?STRING_UNBOUND_REST(C, _) = Bytes, State, OptionalSystemId) when ?is_whitespace(C) ->
    {_WS, Rest, State1} = whitespace(Bytes, State, []),
    check_public_litteral(Rest, State1, OptionalSystemId);
parse_public_id(Bytes, State,OptionalSystemId) ->
    unicode_incomplete_check([Bytes, State, OptionalSystemId, fun parse_public_id/3], 
			     "whitespace expected").


check_public_litteral(?STRING_UNBOUND_REST(C, Rest), State, OptionalSystemId) when C == $'; C == $" ->
    {PubId, Rest1, State1} = parse_pubid_litteral(Rest, State, C, []),
    {SysId, Rest2, State2} = parse_system_id(Rest1, State1, OptionalSystemId),
    {PubId, SysId, Rest2, State2};
check_public_litteral(Bytes, State, OptionalSystemId) ->
    unicode_incomplete_check([Bytes, State, OptionalSystemId, fun check_public_litteral/3], 
			     "\" or \' expected").


%%----------------------------------------------------------------------
%% Function  : parse_doctype_decl(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Rest, State}
%% Description: Parse the DOCTYPE declaration part
%%              [29] markupdecl ::= elementdecl | AttlistDecl | EntityDecl 
%%                                | NotationDecl | PI | Comment 	
%%----------------------------------------------------------------------
parse_doctype_decl(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_doctype_decl/2);
parse_doctype_decl(?STRING("<"), State) ->
    cf(?STRING("<"), State, fun parse_doctype_decl/2);
parse_doctype_decl(?STRING_REST("<?", Rest), State) ->
    case parse_pi(Rest, State) of
	{Rest1, State1} ->
	     parse_doctype_decl(Rest1, State1);
	{endDocument, _Rest1, State1} ->
	    IValue = ?TO_INPUT_FORMAT("<?"),
	    {?APPEND_STRING(IValue, Rest), State1}
    end;
parse_doctype_decl(?STRING_REST("%", Rest), State) ->
    {Ref, Rest1, State1} = parse_pe_reference(Rest, State),
    case Ref of
	{internal_parameter, _, RefValue} ->
	    IValue = ?TO_INPUT_FORMAT(" " ++ RefValue ++ " "),
	    parse_doctype_decl(?APPEND_STRING(IValue, Rest1), State1);
	{external_parameter, _, {PubId, SysId}} ->
	    State2 = parse_external_entity(State1#xmerl_sax_parser_state{file_type = entity}, PubId, SysId),
	    parse_doctype_decl(Rest1, State2);
	 {not_found, Name} ->
	    case State#xmerl_sax_parser_state.skip_external_dtd of
		false ->
		    ?fatal_error(State1, "Entity not declared: " ++ Name); %%WFC: Entity Declared 
		true ->
		    parse_doctype_decl(Rest1, State1)
	    end
    end;
parse_doctype_decl(?STRING_REST("<!", Rest1), State) ->
    parse_doctype_decl_1(Rest1, State);
parse_doctype_decl(?STRING_REST("]", Rest), State) ->
    {Rest, State};
parse_doctype_decl(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->
    {_WS, Rest, State1} = whitespace(Bytes, State, []),
    parse_doctype_decl(Rest, State1);
parse_doctype_decl(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_doctype_decl/2], 
			     "expecting ELEMENT, ATTLIST, ENTITY, NOTATION or comment").


%%----------------------------------------------------------------------
%% Function  : parse_doctype_decl_1(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Rest, State}
%% Description: Main switching function for the different markup declarations
%%              of the DOCTYPE.
%%----------------------------------------------------------------------
parse_doctype_decl_1(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_doctype_decl_1/2);

parse_doctype_decl_1(?STRING("E") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("EL") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("ELE") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("ELEM") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("ELEME") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("ELEMEN") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING_REST("ELEMENT", Rest), State) ->
    {Rest1, State1} = parse_element_decl(Rest, State),
    parse_doctype_decl(Rest1, State1);

parse_doctype_decl_1(?STRING("A") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("AT") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("ATT") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("ATTL") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("ATTLI") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("ATTLIS") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING_REST("ATTLIST", Rest), State) ->
    {Rest1, State1} = parse_att_list_decl(Rest, State),
    parse_doctype_decl(Rest1, State1);

%% E clause not needed here because already taken care of above.
parse_doctype_decl_1(?STRING("EN") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("ENT") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("ENTI") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("ENTIT") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING_REST("ENTITY", Rest), State) ->
    {Rest1, State1} = parse_entity_decl(Rest, State),
    parse_doctype_decl(Rest1, State1);

parse_doctype_decl_1(?STRING("N") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("NO") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("NOT") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("NOTA") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("NOTAT") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("NOTATI") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING("NOTATIO") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING_REST("NOTATION", Rest), State) ->
    {Rest1, State1} = parse_notation_decl(Rest, State),
    parse_doctype_decl(Rest1, State1);
parse_doctype_decl_1(?STRING("-") = Bytes, State) ->
    cf(Bytes, State, fun parse_doctype_decl_1/2);
parse_doctype_decl_1(?STRING_REST("--", Rest), State) ->
    {Rest1, State1} = parse_comment(Rest, State, []),
    parse_doctype_decl(Rest1, State1);
parse_doctype_decl_1(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_doctype_decl_1/2], 
			     "expecting ELEMENT, ATTLIST, ENTITY, NOTATION or comment").


%%----------------------------------------------------------------------
%% Function  : parse_element_decl(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Rest, State}
%% Description: Parse element declarations.
%%              [45] elementdecl ::= '<!ELEMENT' S Name S contentspec S? '>'
%%----------------------------------------------------------------------
parse_element_decl(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_element_decl/2);
parse_element_decl(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->
    {_WS, Rest, State1} = whitespace(Bytes, State, []), 
    parse_element_decl_1(Rest, State1);
parse_element_decl(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_element_decl/2], 
			     "whitespace expected").

parse_element_decl_1(?STRING_UNBOUND_REST(C, Rest), State) ->
    case is_name_start(C) of
	true ->
	    {Name, Rest1, State1} = parse_name(Rest, State, [C]),
	    {Model, Rest2, State2} = parse_element_content(Rest1, State1),
	    State3 =  event_callback({elementDecl, Name, Model}, State2),
	    {Rest2, State3};
	false ->
	    ?fatal_error(State, "name expected")
    end;
parse_element_decl_1(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_element_decl_1/2], 
			     undefined).


%%----------------------------------------------------------------------
%% Function  : parse_element_content(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Rest, State}
%% Description: Parse contents of an element declaration.
%%              [46] contentspec ::= 'EMPTY' | 'ANY' | Mixed | children
%%----------------------------------------------------------------------
parse_element_content(?STRING_EMPTY, State) ->
        cf(?STRING_EMPTY, State, fun parse_element_content/2);
parse_element_content(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->
    {_WS, Rest, State1} = whitespace(Bytes, State, []),
    parse_element_content_1(Rest, State1, []);
parse_element_content(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_element_content/2], 
			     "whitespace expected").


%%----------------------------------------------------------------------
%% Function  : parse_element_content_1(Rest, State, Acc) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Acc = string()
%% Result    : {Content, Rest, State}
%%             Content = string()
%% Description: Parse contents of an element declaration.
%%----------------------------------------------------------------------
parse_element_content_1(?STRING_EMPTY, State, Acc) ->
        cf(?STRING_EMPTY, State, Acc, fun parse_element_content_1/3);
parse_element_content_1(?STRING_REST(">", Rest), State, Acc) ->
    {lists:reverse(delete_leading_whitespace(Acc)), Rest, State};
parse_element_content_1(?STRING_UNBOUND_REST(C, Rest), State, Acc) ->
    parse_element_content_1(Rest, State, [C|Acc]);
parse_element_content_1(Bytes, State, Acc) ->
    unicode_incomplete_check([Bytes, State, Acc, fun parse_element_content_1/3], 
			     undefined).

delete_leading_whitespace([C |Acc]) when ?is_whitespace(C)->
    delete_leading_whitespace(Acc);
delete_leading_whitespace(Acc) ->
    Acc.
								   
%%----------------------------------------------------------------------
%% Function  : parse_att_list_decl(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Rest, State}
%% Description: Parse an attribute list declaration.
%%              [52] AttlistDecl ::= '<!ATTLIST' S Name AttDef* S? '>'
%%----------------------------------------------------------------------
parse_att_list_decl(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_att_list_decl/2);
parse_att_list_decl(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->
    {_WS, Rest, State1} = whitespace(Bytes, State, []), 
    parse_att_list_decl_1(Rest, State1);
parse_att_list_decl(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_att_list_decl/2], 
			     "whitespace expected").


parse_att_list_decl_1(?STRING_UNBOUND_REST(C, Rest), State) ->
    case is_name_start(C) of
	true ->
	    {ElementName, Rest1, State1} = parse_name(Rest, State, [C]),
	    parse_att_defs(Rest1, State1, ElementName);
	false ->
	    ?fatal_error(State, "name expected")
    end;
parse_att_list_decl_1(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_att_list_decl_1/2], 
			     undefined).


%%----------------------------------------------------------------------
%% Function  : parse_att_defs(Rest, State, ElementName) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             ElementName = string()
%% Result    : {Rest, State}
%% Description: Parse an attribute definition.
%%              [53] AttDef ::= S Name S AttType S DefaultDecl
%%----------------------------------------------------------------------
parse_att_defs(?STRING_EMPTY, State, ElementName) ->
    cf(?STRING_EMPTY, State, ElementName, fun parse_att_defs/3);
parse_att_defs(?STRING_REST(">", Rest), State, _ElementName) ->
    {Rest, State};
parse_att_defs(?STRING_UNBOUND_REST(C, _) = Rest, State, ElementName) when ?is_whitespace(C) ->
    {_WS, Rest1, State1} = whitespace(Rest, State, []),
    parse_att_defs(Rest1, State1, ElementName);
parse_att_defs(?STRING_UNBOUND_REST(C, Rest), State, ElementName) ->
    case is_name_start(C) of 
	true ->
	    {AttrName, Rest1, State1} = parse_name(Rest, State, [C]),
	    {Type, Rest2, State2} = parse_att_type(Rest1, State1),
	    {Mode, Value, Rest3, State3} = parse_default_decl(Rest2, State2),
	    State4 = event_callback({attributeDecl, ElementName, AttrName, Type, Mode, Value}, State3),
	    parse_att_defs(Rest3, State4, ElementName);
	false ->
	    ?fatal_error(State, "whitespace or name expected")
    end;
parse_att_defs(Bytes, State, ElementName) ->
    unicode_incomplete_check([Bytes, State, ElementName, fun parse_att_defs/3], 
			     undefined).


%%----------------------------------------------------------------------
%% Function  : parse_att_type(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Type, Rest, State}
%%             Type = string()
%% Description: Parse an attribute type.
%%              [54] AttType ::= StringType | TokenizedType | EnumeratedType 
%%              [55] StringType  ::= 'CDATA'
%%              [56] TokenizedType  ::= 'ID' | 'IDREF' | 'IDREFS' | 'ENTITY'
%%                                    | 'ENTITIES' | 'NMTOKEN' | 'NMTOKENS'
%%              [57] EnumeratedType ::= NotationType | Enumeration
%%              [58] NotationType ::= 'NOTATION' S '(' S? Name (S? '|' S? Name)* S? ')' 
%%              [59] Enumeration ::= '(' S? Nmtoken (S? '|' S? Nmtoken)* S? ')' 
%%----------------------------------------------------------------------
parse_att_type(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_att_type/2);
parse_att_type(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->
    {_WS, Rest, State1} = whitespace(Bytes, State, []),
    case parse_att_type_1(Rest, State1, []) of 
	{Type, Rest1, State2} when Type == "("; Type == "NOTATION" -> 
	    {T, Rest2, State3} = parse_until_right_paren(Rest1, State2, []),
	    {Type ++ T, Rest2, State3};
	{Type, Rest1, State2} ->
	    case check_att_type(Type) of
		true ->
		    {Type, Rest1, State2};
		false ->
		    ?fatal_error(State2, "wrong attribute type")
	    end
    end;
parse_att_type(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_att_type/2], 
			     "whitespace expected").


%%----------------------------------------------------------------------
%% Function  : parse_att_type_1(Rest, State, Acc) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Acc = string()
%% Result    : {Type, Rest, State}
%%             Type = string()
%% Description: Parse an attribute type.
%%----------------------------------------------------------------------
parse_att_type_1(?STRING_EMPTY, State, Acc) ->
    cf(?STRING_EMPTY, State, Acc, fun parse_att_type_1/3);
parse_att_type_1(?STRING_UNBOUND_REST(C, _) = Bytes, State, Acc)  when ?is_whitespace(C) ->
    {lists:reverse(Acc), Bytes, State};
parse_att_type_1(?STRING_REST("(", Rest), State, []) ->
    {"(", Rest, State};
parse_att_type_1(?STRING_UNBOUND_REST(C, Rest), State, Acc) ->
    parse_att_type_1(Rest, State, [C|Acc]);
parse_att_type_1(Bytes, State, Acc) ->
    unicode_incomplete_check([Bytes, State, Acc, fun parse_att_type_1/3], 
			     undefined).

%%----------------------------------------------------------------------
%% Function  : check_att_type(Type) -> Result
%% Parameters: Type = string()
%% Result    : true | false
%% Description:Check if an attribute type is valid.
%%----------------------------------------------------------------------
check_att_type("CDATA") ->
    true;
check_att_type("ID") ->
    true;
check_att_type("IDREF") ->
    true;
check_att_type("IDREFS") ->
    true;
check_att_type("ENTITY") ->
    true;
check_att_type("ENTITIES") ->
    true;
check_att_type("NMTOKEN") ->
    true;
check_att_type("NMTOKENS") ->
    true;
check_att_type(_) ->
    false.


%%----------------------------------------------------------------------
%% Function  : parse_until_right_paren(Rest, State, Acc) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Acc = string()
%% Result    : {Type, Rest, State}
%%             Type = string()
%% Description: Parse an enumurated type until ')'.
%%----------------------------------------------------------------------
parse_until_right_paren(?STRING_EMPTY, State, Acc) ->
    cf(?STRING_EMPTY, State, Acc, fun parse_until_right_paren/3);
parse_until_right_paren(?STRING_REST(")", Rest), State, Acc) ->
    {lists:reverse(")" ++ Acc), Rest, State};
parse_until_right_paren(?STRING_UNBOUND_REST(C, Rest), State, Acc) ->
    parse_until_right_paren(Rest, State, [C|Acc]);
parse_until_right_paren(Bytes, State, Acc) ->
    unicode_incomplete_check([Bytes, State, Acc, fun parse_until_right_paren/3], 
			     undefined).


%%----------------------------------------------------------------------
%% Function  : parse_default_decl(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Default, Rest, State}
%%             Default = string()
%% Description: Parse a default declaration.
%%              [60] DefaultDecl ::= '#REQUIRED' | '#IMPLIED' | (('#FIXED' S)? AttValue)
%%----------------------------------------------------------------------
parse_default_decl(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_default_decl/2);
parse_default_decl(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->
    {_WS, Rest, State1} = whitespace(Bytes, State, []),
    parse_default_decl_1(Rest, State1);
parse_default_decl(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_default_decl/2], 
			     "whitespace expected").


%%----------------------------------------------------------------------
%% Function  : parse_default_decl_1(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Default, Rest, State}
%%             Default = string()
%% Description: Parse a default declaration.
%%----------------------------------------------------------------------
parse_default_decl_1(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_default_decl_1/2);
parse_default_decl_1(?STRING_REST("#", _Rest) = Bytes, State) ->
    case Bytes of
	?STRING("#R") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING("#RE") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING("#REQ") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING("#REQU") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING("#REQUI") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING("#REQUIR") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING("#REQUIRE") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING_REST("#REQUIRED", Rest1) ->
	    {"#REQUIRED", undefined, Rest1, State};

	?STRING("#I") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING("#IM") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING("#IMP") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING("#IMPL") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING("#IMPLI") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING("#IMPLIE") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING_REST("#IMPLIED", Rest1)  ->
	    {"#IMPLIED", undefined, Rest1, State};

	?STRING("#F") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING("#FI") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING("#FIX") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING("#FIXE") ->
	    cf(Bytes, State, fun parse_default_decl_1/2);
	?STRING_REST("#FIXED", Rest1)  ->
	    parse_fixed(Rest1, State);
	_  ->
	    ?fatal_error(State, "REQUIRED, IMPLIED or FIXED expected after #")
    end;
parse_default_decl_1(?STRING_UNBOUND_REST(C, Rest), State) when C == $'; C == $" ->
    {DefaultValue, Rest1, State1} = parse_att_value(Rest, State, C, []),
    {"", DefaultValue, Rest1, State1};
parse_default_decl_1(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_default_decl_1/2], 
			     "bad default declaration").


parse_fixed(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->
    {DefaultValue, Rest, State1} = parse_att_value(Bytes, State), % parse_att_value removes leading WS
    {"#FIXED", DefaultValue, Rest, State1};
parse_fixed(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_fixed/2], 
			     "whitespace expected").

%%----------------------------------------------------------------------
%% Function  : parse_entity_decl(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Rest, State}
%% Description: Parse an entity declaration.
%%              [70] EntityDecl ::= GEDecl | PEDecl
%%              [71] GEDecl ::= '<!ENTITY' S Name S EntityDef S? '>'
%%              [72] PEDecl ::= '<!ENTITY' S '%' S Name S PEDef S? '>'
%%----------------------------------------------------------------------
parse_entity_decl(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_entity_decl/2);
parse_entity_decl(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->
    {_WS, Rest, State1} = whitespace(Bytes, State, []),
    parse_entity_decl_1(Rest, State1);
parse_entity_decl(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_entity_decl/2], 
			     "whitespace expected").


%%----------------------------------------------------------------------
%% Function  : parse_entity_decl_1(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Rest, State}
%% Description: Parse an entity declaration.
%%----------------------------------------------------------------------
parse_entity_decl_1(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_entity_decl_1/2);
parse_entity_decl_1(?STRING_REST("%", Rest), State) ->
    case is_next_char_whitespace(Rest, State) of
	true ->
	    {_WS, Rest1, State1} = whitespace(Rest, State, []),
	    parse_pe_name(Rest1, State1);
	false ->
	    ?fatal_error(State, "whitespace expected")
    end;
parse_entity_decl_1(?STRING_UNBOUND_REST(C, Rest), State) ->
    case is_name_start(C) of
	true ->
	    {Name, Rest1, State1} = parse_name(Rest, State, [C]),
	    case is_next_char_whitespace(Rest1, State1) of
		true ->
		    {_WS, Rest2, State2} = whitespace(Rest1, State1, []),
		    parse_entity_def(Rest2, State2, Name);
		false ->
		    ?fatal_error(State1, "whitespace expected")
	    end;
	false ->
	    ?fatal_error(State, "name or % expected")
    end;
parse_entity_decl_1(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_entity_decl_1/2], 
			     undefined).




parse_pe_name(?STRING_UNBOUND_REST(C, Rest), State) ->
    case is_name_start(C) of
	true ->
	    {Name, Rest1, State1} = parse_name(Rest, State, [C]),
	    case is_next_char_whitespace(Rest1, State1) of
		true ->
		    {_WS, Rest2, State2} = whitespace(Rest1, State1, []),
		    parse_pe_def(Rest2, State2, Name);
		false ->
		    ?fatal_error(State1, "whitespace expected")
	    end;
	false ->
	    ?fatal_error(State, "name expected")
    end;
parse_pe_name(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_pe_name/2], 
			     undefined).



%%----------------------------------------------------------------------
%% Function  : parse_entity_def(Rest, State, Name) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Name = string()
%% Result    : {Rest, State}
%% Description: Parse an entity definition.
%%              [73] EntityDef ::= EntityValue | (ExternalID NDataDecl?)
%%----------------------------------------------------------------------
parse_entity_def(?STRING_EMPTY, State, Name) ->
    cf(?STRING_EMPTY, State, Name, fun parse_entity_def/3);
parse_entity_def(?STRING_UNBOUND_REST(C, Rest), State, Name) when C == $'; C == $" ->
    {Value, Rest1, State1} = parse_entity_value(Rest, State, C, []),
    insert_reference({Name, internal_general, Value}, State1#xmerl_sax_parser_state.ref_table),
    State2 =  event_callback({internalEntityDecl, Name, Value}, State1),
    {_WS, Rest2, State3} = whitespace(Rest1, State2, []),
    parse_def_end(Rest2, State3);
parse_entity_def(?STRING_UNBOUND_REST(C, _) = Rest, State, Name) when C == $S; C == $P  ->
    {PubId, SysId, Rest1, State1} = parse_external_id(Rest, State, false),
    {Ndata, Rest2, State2} = parse_ndata(Rest1, State1),
    case Ndata of
	undefined ->
	    insert_reference({Name, external_general, {PubId, SysId}},
			     State2#xmerl_sax_parser_state.ref_table),
	    State3 =  event_callback({externalEntityDecl, Name, PubId, SysId}, State2),
	    {Rest2, State3};
	_ ->
	    insert_reference({Name, unparsed, {PubId, SysId, Ndata}}, 
			     State2#xmerl_sax_parser_state.ref_table),
	    State3 =  event_callback({unparsedEntityDecl, Name, PubId, SysId, Ndata}, State2),
	    {Rest2, State3}
    end;    
parse_entity_def(Bytes, State, Name) ->
    unicode_incomplete_check([Bytes, State, Name, fun parse_entity_def/3], 
			     "\", \', SYSTEM or PUBLIC expected").


parse_def_end(?STRING_REST(">", Rest), State) ->
    {Rest, State};
parse_def_end(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_def_end/2], 
			     "> expected").



%%----------------------------------------------------------------------
%% Function  : parse_ndata(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Rest, State}
%% Description: Parse an NDATA declaration.
%%              [76] NDataDecl ::= S 'NDATA' S Name
%%----------------------------------------------------------------------
parse_ndata(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_ndata/2);
parse_ndata(?STRING_REST(">", Rest), State) ->
    {undefined, Rest, State};
parse_ndata(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->
    {_WS, Rest1, State1} = whitespace(Bytes, State, []),
    parse_ndata_decl(Rest1, State1);
parse_ndata(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_ndata/2], 
			     "Space before NDATA or > expected").

%%----------------------------------------------------------------------
%% Function  : parse_entity_value(Rest, State, Stop, Acc) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Stop = $' | $"
%%             Acc = string()
%% Result    : {Value, Rest, State}
%%             Value = string()
%% Description: Parse an entity value
%%----------------------------------------------------------------------
parse_entity_value(?STRING_EMPTY, State, undefined, Acc) ->
    {Acc, [], State}; %% stop clause when parsing references
parse_entity_value(?STRING_EMPTY, State, Stop, Acc) ->
    cf(?STRING_EMPTY, State, Stop, Acc, fun parse_entity_value/4);
parse_entity_value(?STRING("\r"), State, Stop, Acc) ->
    cf(?STRING("\r"), State, Stop, Acc, fun parse_entity_value/4);
parse_entity_value(?STRING_REST("\n", Rest), #xmerl_sax_parser_state{line_no=N} = State, Stop, Acc) -> 
    parse_entity_value(Rest, 
		   State#xmerl_sax_parser_state{line_no=N+1}, Stop, [?space |Acc]);
parse_entity_value(?STRING_REST("\r\n", Rest), #xmerl_sax_parser_state{line_no=N} = State, Stop, Acc) -> 
    parse_entity_value(Rest, 
		   State#xmerl_sax_parser_state{line_no=N+1}, Stop, [?space |Acc]);
parse_entity_value(?STRING_REST("\r", Rest), #xmerl_sax_parser_state{line_no=N} = State, Stop, Acc)  -> 
    parse_entity_value(Rest, 
		   State#xmerl_sax_parser_state{line_no=N+1}, Stop, [?space |Acc]);
parse_entity_value(?STRING_REST("\t", Rest), #xmerl_sax_parser_state{line_no=N} = State, Stop, Acc)  -> 
    parse_entity_value(Rest, 
		   State#xmerl_sax_parser_state{line_no=N+1}, Stop, [?space |Acc]);
parse_entity_value(?STRING_REST("&", Rest), State, Stop, Acc)  -> 
    {Ref, Rest1, State1} = parse_reference(Rest, State, false),
    case Ref of 
	{character, _, CharValue}  ->
	    parse_entity_value(Rest1, State1, Stop, [CharValue | Acc]);
	{internal_general, _, Name, _} ->
	    parse_entity_value(Rest1, State1, Stop, ";" ++ lists:reverse(Name) ++ "&" ++ Acc);
	{external_general, Name, _} ->
	    parse_entity_value(Rest1, State1, Stop, ";" ++ lists:reverse(Name) ++ "&" ++ Acc);
	{not_found, Name} ->
	    parse_entity_value(Rest1, State1, Stop, ";" ++ lists:reverse(Name) ++ "&" ++ Acc); 
	{unparsed, Name, _} ->
	    ?fatal_error(State1, "Unparsed entity reference in entity value: " ++ Name)
    end;
parse_entity_value(?STRING_REST("%", Rest), #xmerl_sax_parser_state{file_type=Type} = State, Stop, Acc) ->
    {Ref, Rest1, State1} = parse_pe_reference(Rest, State),
    case Type of
	normal -> %WFC: PEs in Internal Subset
	    {_, Name, _} = Ref,
	    ?fatal_error(State1, "A parameter reference may not occur not within "
			 "markup declarations in the internal DTD subset: " ++ Name);
	_ ->
	    case Ref of 
		{internal_parameter, _, RefValue} ->
		    IValue = ?TO_INPUT_FORMAT(" " ++ RefValue ++ " "),
		    parse_entity_value(?APPEND_STRING(IValue, Rest1), State1, Stop, Acc);
		{external_parameter, _, {_PubId, _SysId}} ->
		    ?fatal_error(State1, "Parameter references in entity value not supported yet.");
		{not_found, Name} ->
		    case State#xmerl_sax_parser_state.skip_external_dtd of
			false ->
			    ?fatal_error(State1, "Entity not declared: " ++ Name); %%VC: Entity Declared
			true ->
			    parse_entity_value(Rest1, State1, Stop, ";" ++ lists:reverse(Name) ++ "&" ++ Acc)
		    end
			
	    end
    end;
parse_entity_value(?STRING_UNBOUND_REST(Stop, Rest), State, Stop, Acc) ->
    {lists:reverse(Acc), Rest, State};
parse_entity_value(?STRING_UNBOUND_REST(C, Rest), State, Stop, Acc)   ->
    if
	?is_char(C) ->
	    parse_entity_value(Rest, State, Stop, [C|Acc]);
	true ->
	     ?fatal_error(State, lists:flatten(io_lib:format("Bad character in entity value: ~p", [C])))
    end;
parse_entity_value(Bytes, State, Stop, Acc)   ->
    unicode_incomplete_check([Bytes, State, Stop, Acc, fun parse_entity_value/4],
			     undefined).

%%----------------------------------------------------------------------
%% Function  : parse_ndata_decl(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Name, Rest, State}
%%             Name = string()
%% Description: Parse an NDATA declaration.
%%              [76] NDataDecl ::= S 'NDATA' S Name
%%----------------------------------------------------------------------
parse_ndata_decl(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_ndata_decl/2);
parse_ndata_decl(?STRING_REST(">", Rest), State) ->
    {undefined, Rest, State};
parse_ndata_decl(?STRING("N") = Bytes, State) ->
    cf(Bytes, State, fun parse_ndata_decl/2);
parse_ndata_decl(?STRING("ND") = Bytes, State) ->
    cf(Bytes, State, fun parse_ndata_decl/2);
parse_ndata_decl(?STRING("NDA") = Bytes, State) ->
    cf(Bytes, State, fun parse_ndata_decl/2);
parse_ndata_decl(?STRING("NDAT") = Bytes, State) ->
    cf(Bytes, State, fun parse_ndata_decl/2);
parse_ndata_decl(?STRING_REST("NDATA", Rest), State) ->
    parse_ndata_decl_1(Rest, State);
parse_ndata_decl(Bytes, State) -> 
    unicode_incomplete_check([Bytes, State, fun parse_ndata_decl/2], 
			     "NDATA or > expected").


parse_ndata_decl_1(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->
    {_WS, Rest, State1} = whitespace(Bytes, State, []),
    parse_ndecl_name(Rest, State1);
parse_ndata_decl_1(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_ndata_decl/2], 
				     "whitespace expected").


parse_ndecl_name(?STRING_UNBOUND_REST(C, Rest), State) ->
    case is_name_start(C) of
	true ->
	    {Name, Rest1, State1} = parse_name(Rest, State, [C]),
	    {_WS, Rest2, State2} = whitespace(Rest1, State1, []),
	    {Rest3, State3} = parse_def_end(Rest2, State2),
	    {Name, Rest3, State3};
	false ->	
	    ?fatal_error(State, "name expected")
    end;
parse_ndecl_name(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_ndecl_name/2], 
			     undefined).

%%----------------------------------------------------------------------
%% Function  : parse_pe_def(Rest, State, Name) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             Name = string()
%% Result    : {Rest, State}
%% Description: Parse an parameter entity definition.
%%              [74] PEDef ::= EntityValue | ExternalID
%%----------------------------------------------------------------------
parse_pe_def(?STRING_EMPTY, State, Name) ->
    cf(?STRING_EMPTY, State, Name, fun parse_pe_def/3);
parse_pe_def(?STRING_UNBOUND_REST(C, Rest), State, Name) when C == $'; C == $" ->
    {Value, Rest1, State1} = parse_entity_value(Rest, State, C, []), 
    Name1 = "%" ++ Name,
    insert_reference({Name1, internal_parameter, Value},
                     State1#xmerl_sax_parser_state.ref_table),
    State2 =  event_callback({internalEntityDecl, Name1, Value}, State1),
    {_WS, Rest2, State3} = whitespace(Rest1, State2, []),
    parse_def_end(Rest2, State3);
parse_pe_def(?STRING_UNBOUND_REST(C, _) = Bytes, State, Name) when C == $S; C == $P  ->
    {PubId, SysId, Rest1, State1} = parse_external_id(Bytes, State, false),
    Name1 = "%" ++ Name,
    insert_reference({Name1, external_parameter, {PubId, SysId}}, 
		     State1#xmerl_sax_parser_state.ref_table),
    State2 =  event_callback({externalEntityDecl, Name1, PubId, SysId}, State1),
    {_WS, Rest2, State3} = whitespace(Rest1, State2, []),
    parse_def_end(Rest2, State3);
parse_pe_def(Bytes, State, Name) ->
    unicode_incomplete_check([Bytes, State, Name, fun parse_pe_def/3], 
			     "\", \', SYSTEM or PUBLIC expected").


%%----------------------------------------------------------------------
%% Function  : parse_notation_decl(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {Rest, State}
%% Description: Parse a NOTATION declaration.
%%              [82] NotationDecl ::= '<!NOTATION' S Name S (ExternalID |  PublicID) S? '>'
%%----------------------------------------------------------------------
parse_notation_decl(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_notation_decl/2);
parse_notation_decl(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->
    {_WS, Rest, State1} = whitespace(Bytes, State, []), 
    parse_notation_decl_1(Rest, State1);
parse_notation_decl(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_notation_decl/2], 
			     "whitespace expected"). 


parse_notation_decl_1(?STRING_UNBOUND_REST(C, Rest), State) ->
    case is_name_start(C) of
	true ->
	    {Name, Rest1, State1} = parse_name(Rest, State, [C]),
	    {PubId, SysId, Rest2, State2} = parse_notation_id(Rest1, State1),
	    State3 =  event_callback({notationDecl, Name, PubId, SysId}, State2),
	    {Rest2, State3};
	false ->
	    ?fatal_error(State, "name expected")
    end;
parse_notation_decl_1(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_notation_decl_1/2], 
			     undefined). 

%%----------------------------------------------------------------------
%% Function  : parse_notation_id(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {PubId, SysId, Rest, State}
%%             PubId = string()
%%             SysId = string()
%% Description: Parse a NOTATION identity. The public id case is a special 
%%              variant of extenal id where just the public part is allowed.
%%              This is allowed if the third parameter in parse_external_id/3 
%%              is true.
%%              [83] PublicID ::= 'PUBLIC' S PubidLiteral 
%%----------------------------------------------------------------------
parse_notation_id(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_notation_id/2);
%parse_notation_id(?STRING_REST(">", Rest), State)  ->
%    {"", "", Rest, State};
parse_notation_id(?STRING_UNBOUND_REST(C, _) = Bytes, State) when ?is_whitespace(C) ->
    {_WS, Rest, State1} = whitespace(Bytes, State, []),
    parse_notation_id_1(Rest, State1);
parse_notation_id(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_notation_id/2], 
			     "whitespace expected").

%%----------------------------------------------------------------------
%% Function  : parse_notation_id_1(Rest, State) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%% Result    : {PubId, SysId, Rest, State}
%%             PubId = string()
%%             SysId = string()
%% Description: Parse a NOTATION identity.
%%----------------------------------------------------------------------
parse_notation_id_1(?STRING_EMPTY, State) ->
    cf(?STRING_EMPTY, State, fun parse_notation_id_1/2);
parse_notation_id_1(?STRING_UNBOUND_REST(C, _) = Bytes, State) when C == $S; C == $P ->
    {PubId, SysId, Rest1, State1} = parse_external_id(Bytes, State, true), 
    {_WS, Rest2, State2} = whitespace(Rest1, State1, []),
    {Rest3, State3} = parse_def_end(Rest2, State2),
    {PubId, SysId, Rest3, State3};
%parse_notation_id_1(?STRING_REST(">", Rest), State) ->
%    {"", "", Rest, State};
parse_notation_id_1(Bytes, State) ->
    unicode_incomplete_check([Bytes, State, fun parse_notation_id_1/2], 
			     "external id or public id expected").


%%======================================================================
%% Character checks and definitions
%%======================================================================

%%----------------------------------------------------------------------
%% Definitions of the first 256 characters
%% 0 - not classified, 
%% 1 - base_char or ideographic, 
%% 2 - combining_char or digit or extender,
%% 3 - $. or $- or $_ or $:
%%----------------------------------------------------------------------
-define(SMALL, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,0,2,2,2,2,2,2,2,2,2,2,3,0,
                0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                1,0,0,0,0,3,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,2,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1}).


%%----------------------------------------------------------------------
%% Function  : is_name_start(Char) -> Result
%% Parameters: Char = char()
%% Result    : true | false
%% Description: Check if character is a valid start of a name.
%%              [5] Name ::= (Letter | '_' | ':') (NameChar)*
%%----------------------------------------------------------------------
is_name_start($_) ->
    true;
is_name_start($:) ->
    true;
is_name_start(C) ->
    is_letter(C).
	    

%%----------------------------------------------------------------------
%% Function  : is_name_start(Char) -> Result
%% Parameters: Char = char()
%% Result    : true | false
%% Description: Check if character is a valid name character.
%%              [4] NameChar ::= Letter | Digit | '.' | '-' | '_' | ':' 
%%                               | CombiningChar | Extender
%%----------------------------------------------------------------------
is_name_char(C) ->
    try element(C, ?SMALL) > 0 
	catch  _:_ ->
		       case is_letter(C) of
			   true ->
			       true;
			   false ->
			       case is_digit(C) of
				   true -> true;
				   false ->
				       case is_combining_char(C) of
					   true -> true;
					   false ->
					       is_extender(C)
				       end
			       end
		       end
	       end.


%%----------------------------------------------------------------------
%% Function  : is_pubid_char(Char) -> Result
%% Parameters: Char = char()
%% Result    : true | false
%% Description: Check if character is a public identity character.
%%              [13] PubidChar ::= #x20 | #xD | #xA | [a-zA-Z0-9] 
%%                                 | [-'()+,./:=?;!*#@$_%]
%%----------------------------------------------------------------------
is_pubid_char(?space) ->
    true;
is_pubid_char(?cr) ->
    true;
is_pubid_char(?lf) ->
    true;
is_pubid_char($!) ->
    true;
is_pubid_char($:) ->
    true;
is_pubid_char($;) ->
    true;
is_pubid_char($=) ->
    true;
is_pubid_char($@) ->
    true;
is_pubid_char($_) ->
    true;
is_pubid_char(C) when $# =< C, C =< $% ->
    true;
is_pubid_char(C) when $' =< C, C =< $/ ->
    true;
is_pubid_char(C) ->
    case is_letter(C) of
	true ->
	    true;
	false ->
	    is_digit(C)
    end.


%%----------------------------------------------------------------------
%% Function  : is_letter(Char) -> Result
%% Parameters: Char = char()
%% Result    : true | false
%% Description: Check if character is a letter.
%%              [84] Letter ::= BaseChar | Ideographic
%%----------------------------------------------------------------------
is_letter(C) ->
    try element(C, ?SMALL) =:= 1
    catch _:_ -> 
        case is_base_char(C) of
	    false ->
	        is_ideographic(C);
    	    true ->
	        true
        end
    end.


%%----------------------------------------------------------------------
%% Function  : is_letter(Char) -> Result
%% Parameters: Char = char()
%% Result    : true | false
%% Description: Check if character is a basic character.
%%              [85] BaseChar 
%%----------------------------------------------------------------------
is_base_char(C) when C >= 16#0041, C =< 16#005A -> true; %% ASCII Latin
is_base_char(C) when C >= 16#0061, C =< 16#007A -> true;
is_base_char(C) when C >= 16#00C0, C =< 16#00D6 -> true; %% ISO Latin
is_base_char(C) when C >= 16#00D8, C =< 16#00F6 -> true;
is_base_char(C) when C >= 16#00F8, C =< 16#00FF -> true;
is_base_char(C) when C >= 16#0100, C =< 16#0131 -> true; %% Accented Latin
is_base_char(C) when C >= 16#0134, C =< 16#013E -> true;
is_base_char(C) when C >= 16#0141, C =< 16#0148 -> true;
is_base_char(C) when C >= 16#014A, C =< 16#017E -> true;
is_base_char(C) when C >= 16#0180, C =< 16#01C3 -> true;
is_base_char(C) when C >= 16#01CD, C =< 16#01F0 -> true;
is_base_char(C) when C >= 16#01F4, C =< 16#01F5 -> true;
is_base_char(C) when C >= 16#01FA, C =< 16#0217 -> true;
is_base_char(C) when C >= 16#0250, C =< 16#02A8 -> true; %% IPA
is_base_char(C) when C >= 16#02BB, C =< 16#02C1 -> true; %% Spacing Modifiers
is_base_char(16#0386) -> true;                           %% Greek
is_base_char(C) when C >= 16#0388, C =< 16#038A -> true;
is_base_char(16#038C) -> true;
is_base_char(C) when C >= 16#038E, C =< 16#03A1 -> true;
is_base_char(C) when C >= 16#03A3, C =< 16#03CE -> true;
is_base_char(C) when C >= 16#03D0, C =< 16#03D6 -> true;
is_base_char(16#03DA) -> true;
is_base_char(16#03DC) -> true;
is_base_char(16#03DE) -> true;
is_base_char(16#03E0) -> true;
is_base_char(C) when C >= 16#03E2, C =< 16#03F3 -> true;
is_base_char(C) when C >= 16#0401, C =< 16#040C -> true; %% Cyrillic
is_base_char(C) when C >= 16#040E, C =< 16#044F -> true;
is_base_char(C) when C >= 16#0451, C =< 16#045C -> true;
is_base_char(C) when C >= 16#045E, C =< 16#0481 -> true;
is_base_char(C) when C >= 16#0490, C =< 16#04C4 -> true;
is_base_char(C) when C >= 16#04C7, C =< 16#04C8 -> true;
is_base_char(C) when C >= 16#04CB, C =< 16#04CC -> true;
is_base_char(C) when C >= 16#04D0, C =< 16#04EB -> true;
is_base_char(C) when C >= 16#04EE, C =< 16#04F5 -> true;
is_base_char(C) when C >= 16#04F8, C =< 16#04F9 -> true;
is_base_char(C) when C >= 16#0531, C =< 16#0556 -> true; %% Armenian
is_base_char(16#0559) -> true;
is_base_char(C) when C >= 16#0561, C =< 16#0586 -> true;
is_base_char(C) when C >= 16#05D0, C =< 16#05EA -> true; %% Hebrew
is_base_char(C) when C >= 16#05F0, C =< 16#05F2 -> true;
is_base_char(C) when C >= 16#0621, C =< 16#063A -> true; %% Arabic
is_base_char(C) when C >= 16#0641, C =< 16#064A -> true;
is_base_char(C) when C >= 16#0671, C =< 16#06B7 -> true;
is_base_char(C) when C >= 16#06BA, C =< 16#06BE -> true;
is_base_char(C) when C >= 16#06C0, C =< 16#06CE -> true;
is_base_char(C) when C >= 16#06D0, C =< 16#06D3 -> true;
is_base_char(16#06D5) -> true;
is_base_char(C) when C >= 16#06E5, C =< 16#06E6 -> true;
is_base_char(C) when C >= 16#0905, C =< 16#0939 -> true; %% Devanagari
is_base_char(16#093D) -> true;
is_base_char(C) when C >= 16#0958, C =< 16#0961 -> true;
is_base_char(C) when C >= 16#0985, C =< 16#098C -> true; %% Bengali
is_base_char(C) when C >= 16#098F, C =< 16#0990 -> true;
is_base_char(C) when C >= 16#0993, C =< 16#09A8 -> true;
is_base_char(C) when C >= 16#09AA, C =< 16#09B0 -> true;
is_base_char(16#09B2) -> true;
is_base_char(C) when C >= 16#09B6, C =< 16#09B9 -> true;
is_base_char(C) when C >= 16#09DC, C =< 16#09DD -> true;
is_base_char(C) when C >= 16#09DF, C =< 16#09E1 -> true;
is_base_char(C) when C >= 16#09F0, C =< 16#09F1 -> true;
is_base_char(C) when C >= 16#0A05, C =< 16#0A0A -> true; %% Gurmukhi
is_base_char(C) when C >= 16#0A0F, C =< 16#0A10 -> true;
is_base_char(C) when C >= 16#0A13, C =< 16#0A28 -> true;
is_base_char(C) when C >= 16#0A2A, C =< 16#0A30 -> true;
is_base_char(C) when C >= 16#0A32, C =< 16#0A33 -> true;
is_base_char(C) when C >= 16#0A35, C =< 16#0A36 -> true;
is_base_char(C) when C >= 16#0A38, C =< 16#0A39 -> true;
is_base_char(C) when C >= 16#0A59, C =< 16#0A5C -> true;
is_base_char(16#0A5E) -> true;
is_base_char(C) when C >= 16#0A72, C =< 16#0A74 -> true;
is_base_char(C) when C >= 16#0A85, C =< 16#0A8B -> true; %% Gujarati
is_base_char(16#0A8D) -> true;
is_base_char(C) when C >= 16#0A8F, C =< 16#0A91 -> true;
is_base_char(C) when C >= 16#0A93, C =< 16#0AA8 -> true;
is_base_char(C) when C >= 16#0AAA, C =< 16#0AB0 -> true;
is_base_char(C) when C >= 16#0AB2, C =< 16#0AB3 -> true;
is_base_char(C) when C >= 16#0AB5, C =< 16#0AB9 -> true;
is_base_char(16#0ABD) -> true;
is_base_char(16#0AE0) -> true;
is_base_char(C) when C >= 16#0B05, C =< 16#0B0C -> true; %% Oriya
is_base_char(C) when C >= 16#0B0F, C =< 16#0B10 -> true;
is_base_char(C) when C >= 16#0B13, C =< 16#0B28 -> true;
is_base_char(C) when C >= 16#0B2A, C =< 16#0B30 -> true;
is_base_char(C) when C >= 16#0B32, C =< 16#0B33 -> true;
is_base_char(C) when C >= 16#0B36, C =< 16#0B39 -> true;
is_base_char(16#0B3D) -> true;
is_base_char(C) when C >= 16#0B5C, C =< 16#0B5D -> true;
is_base_char(C) when C >= 16#0B5F, C =< 16#0B61 -> true;
is_base_char(C) when C >= 16#0B85, C =< 16#0B8A -> true; %% Tamil
is_base_char(C) when C >= 16#0B8E, C =< 16#0B90 -> true;
is_base_char(C) when C >= 16#0B92, C =< 16#0B95 -> true;
is_base_char(C) when C >= 16#0B99, C =< 16#0B9A -> true;
is_base_char(16#0B9C) -> true;
is_base_char(C) when C >= 16#0B9E, C =< 16#0B9F -> true;
is_base_char(C) when C >= 16#0BA3, C =< 16#0BA4 -> true;
is_base_char(C) when C >= 16#0BA8, C =< 16#0BAA -> true;
is_base_char(C) when C >= 16#0BAE, C =< 16#0BB5 -> true;
is_base_char(C) when C >= 16#0BB7, C =< 16#0BB9 -> true;
is_base_char(C) when C >= 16#0C05, C =< 16#0C0C -> true; %% Telugu
is_base_char(C) when C >= 16#0C0E, C =< 16#0C10 -> true;
is_base_char(C) when C >= 16#0C12, C =< 16#0C28 -> true;
is_base_char(C) when C >= 16#0C2A, C =< 16#0C33 -> true;
is_base_char(C) when C >= 16#0C35, C =< 16#0C39 -> true;
is_base_char(C) when C >= 16#0C60, C =< 16#0C61 -> true;
is_base_char(C) when C >= 16#0C85, C =< 16#0C8C -> true; %% Kannada
is_base_char(C) when C >= 16#0C8E, C =< 16#0C90 -> true;
is_base_char(C) when C >= 16#0C92, C =< 16#0CA8 -> true;
is_base_char(C) when C >= 16#0CAA, C =< 16#0CB3 -> true;
is_base_char(C) when C >= 16#0CB5, C =< 16#0CB9 -> true;
is_base_char(16#0CDE) -> true;
is_base_char(C) when C >= 16#0CE0, C =< 16#0CE1 -> true;
is_base_char(C) when C >= 16#0D05, C =< 16#0D0C -> true; %% Malayalam
is_base_char(C) when C >= 16#0D0E, C =< 16#0D10 -> true;
is_base_char(C) when C >= 16#0D12, C =< 16#0D28 -> true;
is_base_char(C) when C >= 16#0D2A, C =< 16#0D39 -> true;
is_base_char(C) when C >= 16#0D60, C =< 16#0D61 -> true;
is_base_char(C) when C >= 16#0E01, C =< 16#0E2E -> true; %% Thai
is_base_char(16#0E30) -> true;
is_base_char(C) when C >= 16#0E32, C =< 16#0E33 -> true;
is_base_char(C) when C >= 16#0E40, C =< 16#0E45 -> true;
is_base_char(C) when C >= 16#0E81, C =< 16#0E82 -> true; %% Lao
is_base_char(16#0E84) -> true;
is_base_char(C) when C >= 16#0E87, C =< 16#0E88 -> true;
is_base_char(16#0E8A) -> true;
is_base_char(16#0E8D) -> true;
is_base_char(C) when C >= 16#0E94, C =< 16#0E97 -> true;
is_base_char(C) when C >= 16#0E99, C =< 16#0E9F -> true;
is_base_char(C) when C >= 16#0EA1, C =< 16#0EA3 -> true;
is_base_char(16#0EA5) -> true;
is_base_char(16#0EA7) -> true;
is_base_char(C) when C >= 16#0EAA, C =< 16#0EAB -> true;
is_base_char(C) when C >= 16#0EAD, C =< 16#0EAE -> true;
is_base_char(16#0EB0) -> true;
is_base_char(C) when C >= 16#0EB2, C =< 16#0EB3 -> true;
is_base_char(16#0EBD) -> true;
is_base_char(C) when C >= 16#0EC0, C =< 16#0EC4 -> true;
is_base_char(C) when C >= 16#0F40, C =< 16#0F47 -> true; %% Tibetan
is_base_char(C) when C >= 16#0F49, C =< 16#0F69 -> true;
is_base_char(C) when C >= 16#10A0, C =< 16#10C5 -> true; %% Hangul Jamo
is_base_char(C) when C >= 16#10D0, C =< 16#10F6 -> true;
is_base_char(16#1100) -> true;
is_base_char(C) when C >= 16#1102, C =< 16#1103 -> true;
is_base_char(C) when C >= 16#1105, C =< 16#1107 -> true;
is_base_char(16#1109) -> true;
is_base_char(C) when C >= 16#110B, C =< 16#110C -> true;
is_base_char(C) when C >= 16#110E, C =< 16#1112 -> true;
is_base_char(16#113C) -> true;
is_base_char(16#113E) -> true;
is_base_char(16#1140) -> true;
is_base_char(16#114C) -> true;
is_base_char(16#114E) -> true;
is_base_char(16#1150) -> true;
is_base_char(C) when C >= 16#1154, C =< 16#1155 -> true;
is_base_char(16#1159) -> true;
is_base_char(C) when C >= 16#115F, C =< 16#1161 -> true;
is_base_char(16#1163) -> true;
is_base_char(16#1165) -> true;
is_base_char(16#1167) -> true;
is_base_char(16#1169) -> true;
is_base_char(C) when C >= 16#116D, C =< 16#116E -> true;
is_base_char(C) when C >= 16#1172, C =< 16#1173 -> true;
is_base_char(16#1175) -> true;
is_base_char(16#119E) -> true;
is_base_char(16#11A8) -> true;
is_base_char(16#11AB) -> true;
is_base_char(C) when C >= 16#11AE, C =< 16#11AF -> true;
is_base_char(C) when C >= 16#11B7, C =< 16#11B8 -> true;
is_base_char(16#11BA) -> true;
is_base_char(C) when C >= 16#11BC, C =< 16#11C2 -> true;
is_base_char(16#11EB) -> true;
is_base_char(16#11F0) -> true;
is_base_char(16#11F9) -> true;
is_base_char(C) when C >= 16#1E00, C =< 16#1E9B -> true; %% Latin Extended Additional
is_base_char(C) when C >= 16#1EA0, C =< 16#1EF9 -> true;
is_base_char(C) when C >= 16#1F00, C =< 16#1F15 -> true; %% Greek Extended
is_base_char(C) when C >= 16#1F18, C =< 16#1F1D -> true;
is_base_char(C) when C >= 16#1F20, C =< 16#1F45 -> true;
is_base_char(C) when C >= 16#1F48, C =< 16#1F4D -> true;
is_base_char(C) when C >= 16#1F50, C =< 16#1F57 -> true;
is_base_char(16#1F59) -> true;
is_base_char(16#1F5B) -> true;
is_base_char(16#1F5D) -> true;
is_base_char(C) when C >= 16#1F5F, C =< 16#1F7D -> true;
is_base_char(C) when C >= 16#1F80, C =< 16#1FB4 -> true;
is_base_char(C) when C >= 16#1FB6, C =< 16#1FBC -> true;
is_base_char(16#1FBE) -> true;
is_base_char(C) when C >= 16#1FC2, C =< 16#1FC4 -> true;
is_base_char(C) when C >= 16#1FC6, C =< 16#1FCC -> true;
is_base_char(C) when C >= 16#1FD0, C =< 16#1FD3 -> true;
is_base_char(C) when C >= 16#1FD6, C =< 16#1FDB -> true;
is_base_char(C) when C >= 16#1FE0, C =< 16#1FEC -> true;
is_base_char(C) when C >= 16#1FF2, C =< 16#1FF4 -> true;
is_base_char(C) when C >= 16#1FF6, C =< 16#1FFC -> true;
is_base_char(16#2126) -> true;                           %% Letterlike Symbols
is_base_char(C) when C >= 16#212A, C =< 16#212B -> true;
is_base_char(16#212E) -> true;
is_base_char(C) when C >= 16#2180, C =< 16#2182 -> true; %% Number Forms
is_base_char(C) when C >= 16#3041, C =< 16#3094 -> true; %% Hiragana
is_base_char(C) when C >= 16#30A1, C =< 16#30FA -> true; %% Katakana
is_base_char(C) when C >= 16#3105, C =< 16#312C -> true; %% Bopomofo
is_base_char(C) when C >= 16#ac00, C =< 16#d7a3 -> true; %% Hangul Syllables
is_base_char(_) ->
    false.

%%----------------------------------------------------------------------
%% Function  : is_ideographic(Char) -> Result
%% Parameters: Char = char()
%% Result    : true | false
%% Description: Check if character is an ideographic letter.
%%              [86] Ideographic 	
%%----------------------------------------------------------------------
is_ideographic(C) when C >= 16#4e00, C =< 16#9fa5 -> true; %% Unified CJK Ideographs
is_ideographic(16#3007) -> true;                           %% CJK Symbols and Punctuation
is_ideographic(C) when C >= 16#3021, C =< 16#3029 -> true;
is_ideographic(_) ->
    false.

%%----------------------------------------------------------------------
%% Function  : is_ideographic(Char) -> Result
%% Parameters: Char = char()
%% Result    : true | false
%% Description: Check if character is a combining character.
%% [87] CombiningChar
%%----------------------------------------------------------------------
is_combining_char(C) when C >= 16#0300, C =< 16#0345 -> true; %% Combining Diacritics
is_combining_char(C) when C >= 16#0360, C =< 16#0361 -> true;
is_combining_char(C) when C >= 16#0483, C =< 16#0486 -> true; %% Cyrillic Combining Diacritics
is_combining_char(C) when C >= 16#0591, C =< 16#05a1 -> true; %% Hebrew Combining Diacritics
is_combining_char(C) when C >= 16#05a3, C =< 16#05b9 -> true;
is_combining_char(C) when C >= 16#05bb, C =< 16#05bd -> true;
is_combining_char(16#05bf) -> true;
is_combining_char(C) when C >= 16#05c1, C =< 16#05c2 -> true;
is_combining_char(16#05c4) -> true;
is_combining_char(C) when C >= 16#064b, C =< 16#0652 -> true; %% Arabic Combining Diacritics
is_combining_char(16#0670) -> true;
is_combining_char(C) when C >= 16#06d6, C =< 16#06dc -> true;
is_combining_char(C) when C >= 16#06dd, C =< 16#06df -> true;
is_combining_char(C) when C >= 16#06e0, C =< 16#06e4 -> true;
is_combining_char(C) when C >= 16#06e7, C =< 16#06e8 -> true;
is_combining_char(C) when C >= 16#06ea, C =< 16#06ed -> true;
is_combining_char(C) when C >= 16#0901, C =< 16#0903 -> true; %% Devanagari Combining Diacritics
is_combining_char(16#093c) -> true;
is_combining_char(C) when C >= 16#093e, C =< 16#094c -> true;
is_combining_char(16#094d) -> true;
is_combining_char(C) when C >= 16#0951, C =< 16#0954 -> true;
is_combining_char(C) when C >= 16#0962, C =< 16#0963 -> true;
is_combining_char(C) when C >= 16#0981, C =< 16#0983 -> true; %% Bengali Combining Diacritics
is_combining_char(16#09bc) -> true;
is_combining_char(16#09be) -> true;
is_combining_char(16#09bf) -> true;
is_combining_char(C) when C >= 16#09c0, C =< 16#09c4 -> true;
is_combining_char(C) when C >= 16#09c7, C =< 16#09c8 -> true;
is_combining_char(C) when C >= 16#09cb, C =< 16#09cd -> true;
is_combining_char(16#09d7) -> true;
is_combining_char(C) when C >= 16#09e2, C =< 16#09e3 -> true;
is_combining_char(16#0a02) -> true;                           %% Gurmukhi Combining Diacritics
is_combining_char(16#0a3c) -> true;
is_combining_char(16#0a3e) -> true;
is_combining_char(16#0a3f) -> true;
is_combining_char(C) when C >= 16#0a40, C =< 16#0a42 -> true;
is_combining_char(C) when C >= 16#0a47, C =< 16#0a48 -> true;
is_combining_char(C) when C >= 16#0a4b, C =< 16#0a4d -> true;
is_combining_char(C) when C >= 16#0a70, C =< 16#0a71 -> true;
is_combining_char(C) when C >= 16#0a81, C =< 16#0a83 -> true; %% Gujarati Combining Diacritics
is_combining_char(16#0abc) -> true;
is_combining_char(C) when C >= 16#0abe, C =< 16#0ac5 -> true;
is_combining_char(C) when C >= 16#0ac7, C =< 16#0ac9 -> true;
is_combining_char(C) when C >= 16#0acb, C =< 16#0acd -> true;
is_combining_char(C) when C >= 16#0b01, C =< 16#0b03 -> true; %% Oriya Combining Diacritics
is_combining_char(16#0b3c) -> true;
is_combining_char(C) when C >= 16#0b3e, C =< 16#0b43 -> true;
is_combining_char(C) when C >= 16#0b47, C =< 16#0b48 -> true;
is_combining_char(C) when C >= 16#0b4b, C =< 16#0b4d -> true;
is_combining_char(C) when C >= 16#0b56, C =< 16#0b57 -> true;
is_combining_char(C) when C >= 16#0b82, C =< 16#0b83 -> true; %% Tamil Combining Diacritics
is_combining_char(C) when C >= 16#0bbe, C =< 16#0bc2 -> true;
is_combining_char(C) when C >= 16#0bc6, C =< 16#0bc8 -> true;
is_combining_char(C) when C >= 16#0bca, C =< 16#0bcd -> true;
is_combining_char(16#0bd7) -> true;
is_combining_char(C) when C >= 16#0c01, C =< 16#0c03 -> true; %% Telugu Combining Diacritics
is_combining_char(C) when C >= 16#0c3e, C =< 16#0c44 -> true;
is_combining_char(C) when C >= 16#0c46, C =< 16#0c48 -> true;
is_combining_char(C) when C >= 16#0c4a, C =< 16#0c4d -> true;
is_combining_char(C) when C >= 16#0c55, C =< 16#0c56 -> true;
is_combining_char(C) when C >= 16#0c82, C =< 16#0c83 -> true; %% Kannada Combining Diacritics
is_combining_char(C) when C >= 16#0cbe, C =< 16#0cc4 -> true;
is_combining_char(C) when C >= 16#0cc6, C =< 16#0cc8 -> true;
is_combining_char(C) when C >= 16#0cca, C =< 16#0ccd -> true;
is_combining_char(C) when C >= 16#0cd5, C =< 16#0cd6 -> true;
is_combining_char(C) when C >= 16#0d02, C =< 16#0d03 -> true; %% Malayalam Combining Diacritics
is_combining_char(C) when C >= 16#0d3e, C =< 16#0d43 -> true;
is_combining_char(C) when C >= 16#0d46, C =< 16#0d48 -> true;
is_combining_char(C) when C >= 16#0d4a, C =< 16#0d4d -> true;
is_combining_char(16#0d57) -> true;
is_combining_char(16#0e31) -> true;                           %% Thai Combining Diacritics
is_combining_char(C) when C >= 16#0e34, C =< 16#0e3a -> true;
is_combining_char(C) when C >= 16#0e47, C =< 16#0e4e -> true;
is_combining_char(16#0eb1) -> true;                           %% Lao Combining Diacritics
is_combining_char(C) when C >= 16#0eb4, C =< 16#0eb9 -> true;
is_combining_char(C) when C >= 16#0ebb, C =< 16#0ebc -> true;
is_combining_char(C) when C >= 16#0ec8, C =< 16#0ecd -> true;
is_combining_char(C) when C >= 16#0f18, C =< 16#0f19 -> true; %% Tibetan Combining Diacritics
is_combining_char(16#0f35) -> true;
is_combining_char(16#0f37) -> true;
is_combining_char(16#0f39) -> true;
is_combining_char(16#0f3e) -> true;
is_combining_char(16#0f3f) -> true;
is_combining_char(C) when C >= 16#0f71, C =< 16#0f84 -> true;
is_combining_char(C) when C >= 16#0f86, C =< 16#0f8b -> true;
is_combining_char(C) when C >= 16#0f90, C =< 16#0f95 -> true;
is_combining_char(16#0f97) -> true;
is_combining_char(C) when C >= 16#0f99, C =< 16#0fad -> true;
is_combining_char(C) when C >= 16#0fb1, C =< 16#0fb7 -> true;
is_combining_char(16#0fb9) -> true;
is_combining_char(C) when C >= 16#20d0, C =< 16#20dc -> true; %% Math/Technical Combining Diacritics
is_combining_char(16#20e1) -> true;
is_combining_char(C) when C >= 16#302a, C =< 16#302f -> true; %% Ideographic Diacritics
is_combining_char(16#3099) -> true;                           %% Hiragana/Katakana Combining Diacritics
is_combining_char(16#309a) -> true;
is_combining_char(_) -> false.


%%----------------------------------------------------------------------
%% Function  : is_digit(Char) -> Result
%% Parameters: Char = char()
%% Result    : true | false
%% Description: Check if character is a digit.
%%              [88] Digit
%%----------------------------------------------------------------------
is_digit(C) when C >= 16#0030, C =< 16#0039 -> true; %% Basic ASCII digits 0-9
is_digit(C) when C >= 16#0660, C =< 16#0669 -> true; %% Arabic Digits 0-9
is_digit(C) when C >= 16#06F0, C =< 16#06F9 -> true; %% Eastern Arabic-Indic Digits 0-9
is_digit(C) when C >= 16#0966, C =< 16#096f -> true; %% Devanagari Digits 0-9
is_digit(C) when C >= 16#09e6, C =< 16#09ef -> true; %% Bengali Digits 0-9
is_digit(C) when C >= 16#0a66, C =< 16#0a6f -> true; %% Gurmukhi Digits 0-9
is_digit(C) when C >= 16#0ae6, C =< 16#0aef -> true; %% Gujarati Digits 0-9
is_digit(C) when C >= 16#0b66, C =< 16#0b6f -> true; %% Oriya Digits 0-9
is_digit(C) when C >= 16#0be7, C =< 16#0bef -> true; %% Tamil Digits 0-9
is_digit(C) when C >= 16#0c66, C =< 16#0c6f -> true; %% Telugu Digits 0-9
is_digit(C) when C >= 16#0ce6, C =< 16#0cef -> true; %% Kannada Digits 0-9
is_digit(C) when C >= 16#0d66, C =< 16#0d6f -> true; %% Malayalam Digits 0-9
is_digit(C) when C >= 16#0e50, C =< 16#0e59 -> true; %% Thai Digits 0-9
is_digit(C) when C >= 16#0ed0, C =< 16#0ed9 -> true; %% Lao Digits 0-9
is_digit(C) when C >= 16#0f20, C =< 16#0f29 -> true; %% Tibetan Digits 0-9
is_digit(_) -> false.


%%----------------------------------------------------------------------
%% Function  : is_extender(Char) -> Result
%% Parameters: Char = char()
%% Result    : true | false
%% Description: Check if character is an extender character.
%%              [89] Extender
%%----------------------------------------------------------------------
is_extender(16#00b7) -> true;                           %% Middle Dot
is_extender(16#02d0) -> true;                           %% Triangular Colon and Half Colon
is_extender(16#02d1) -> true;
is_extender(16#0387) -> true;                           %% Greek Ano Teleia
is_extender(16#0640) -> true;                           %% Arabic Tatweel
is_extender(16#0e46) -> true;                           %% Thai Maiyamok
is_extender(16#0ec6) -> true;                           %% Lao Ko La
is_extender(16#3005) -> true;                           %% Ideographic Iteration Mark
is_extender(C) when C >= 16#3031, C =< 16#3035 -> true; %% Japanese Kana Repetition Marks
is_extender(C) when C >= 16#309d, C =< 16#309e -> true; %% Japanese Hiragana Iteration Marks
is_extender(C) when C >= 16#30fc, C =< 16#30fe -> true; %% Japanese Kana Iteration Marks
is_extender(_) -> false.



%%======================================================================
%% Callback and Continuation function handling
%%======================================================================
%%----------------------------------------------------------------------
%% Function  : event_callback(Event, State) -> Result
%% Parameters: Event = term()
%%             State = #xmerl_sax_parser_state{}
%% Result    : #xmerl_sax_parser_state{}
%% Description: Function that uses provided fun to send parser events.
%%----------------------------------------------------------------------
event_callback(Event, 
	       #xmerl_sax_parser_state{
		 event_fun=CbFun, 
		 event_state=EventState, 
		 line_no=N,
		 entity=E,
		 current_location=L
		} = State) ->
    try 
	NewEventState = CbFun(Event, {L, E, N}, EventState),
	State#xmerl_sax_parser_state{event_state=NewEventState}
    catch
	throw:ErrorTerm ->
	    throw({event_receiver_error, State, ErrorTerm});
	  exit:Reason ->
	    throw({event_receiver_error, State, {'EXIT', Reason}})
    end.

%%----------------------------------------------------------------------
%% Function  : cf(Rest, State, NextCall) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             NextCall = fun()
%% Result    : {Rest, State}
%% Description: Function that uses provided fun to read another chunk from
%%              input stream and calls the fun in NextCall.
%%----------------------------------------------------------------------
cf(_Rest, #xmerl_sax_parser_state{continuation_fun = undefined} = State, _) ->
    ?fatal_error(State, "Continuation function undefined"); 
cf(Rest, #xmerl_sax_parser_state{continuation_fun = CFun, continuation_state = CState} = State, 
   NextCall) ->
    Result = 
	try
	    CFun(CState)
	catch
	    throw:ErrorTerm ->
		?fatal_error(State, ErrorTerm);
	      exit:Reason ->
		?fatal_error(State, {'EXIT', Reason})
	end,
    case Result of
	{?STRING_EMPTY, _} ->
	    ?fatal_error(State, "No more bytes"); 
	{NewBytes, NewContState} ->
	    NextCall(?APPEND_STRING(Rest, NewBytes),  
		     State#xmerl_sax_parser_state{continuation_state = NewContState})
    end.

%%----------------------------------------------------------------------
%% Function  : cf(Rest, State, NextCall, P) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             NextCall = fun()
%%             P = term()
%% Result    : {Rest, State}
%% Description: Function that uses provided fun to read another chunk from
%%              input stream and calls the fun in NextCall with P as last parameter.
%%----------------------------------------------------------------------
cf(_Rest, #xmerl_sax_parser_state{continuation_fun = undefined} = State, _P, _) ->
    ?fatal_error(State, "Continuation function undefined"); 
cf(Rest, #xmerl_sax_parser_state{continuation_fun = CFun, continuation_state = CState} = State, 
   P, NextCall) ->
    Result = 
	    try
		CFun(CState)
	    catch
		throw:ErrorTerm ->
		    ?fatal_error(State, ErrorTerm);
		  exit:Reason ->
		    ?fatal_error(State, {'EXIT', Reason})
	    end,
    case Result of
	{?STRING_EMPTY,  _} ->
	    ?fatal_error(State, "No more bytes"); 
	{NewBytes, NewContState} ->
	    NextCall(?APPEND_STRING(Rest, NewBytes),  
		     State#xmerl_sax_parser_state{continuation_state = NewContState},
		     P)
    end.


%%----------------------------------------------------------------------
%% Function  : cf(Rest, State, P1, P2, NextCall) -> Result
%% Parameters: Rest = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             NextCall = fun()
%%             P1 = term()
%%             P2 = term()
%% Result    : {Rest, State}
%% Description: Function that uses provided fun to read another chunk from
%%              input stream and calls the fun in NextCall with P1 and
%%              P2 as last parameters.
%%----------------------------------------------------------------------
cf(_Rest, #xmerl_sax_parser_state{continuation_fun = undefined} = State, _P1, _P2, _) ->
    ?fatal_error(State, "Continuation function undefined"); 
cf(Rest, #xmerl_sax_parser_state{continuation_fun = CFun, continuation_state = CState} = State, 
   P1, P2, NextCall) ->
    Result = 
	    try
		CFun(CState)
	    catch
		throw:ErrorTerm ->
		    ?fatal_error(State, ErrorTerm);
		  exit:Reason ->
		    ?fatal_error(State, {'EXIT', Reason})
	    end,
    case Result of
	{?STRING_EMPTY,  _} ->
	    ?fatal_error(State, "No more bytes"); 
	{NewBytes, NewContState} ->
	    NextCall(?APPEND_STRING(Rest, NewBytes), 
		     State#xmerl_sax_parser_state{continuation_state = NewContState},
		     P1, P2)
    end.



%%----------------------------------------------------------------------
%% Function  : unicode_incomplete_check(Args, ErrString) -> Result
%% Parameters: Args = [Bytes, State | RestOfArgs]
%%             Bytes = string() | binary()
%%             State = #xmerl_sax_parser_state{}
%%             RestOfArgs = 
%%             ErrString = string()
%% Result    : {Rest, State}
%% Description: 
%%----------------------------------------------------------------------
unicode_incomplete_check([Bytes, #xmerl_sax_parser_state{encoding=Enc} = State | _] = Args, ErrString) when is_binary(Bytes) ->
    case unicode:characters_to_list(Bytes, Enc) of 
	{incomplete, _, _} ->
	    apply(?MODULE, cf, Args);
	{error, _Encoded, _Rest} ->
	    ?fatal_error(State, lists:flatten(io_lib:format("Bad character, not in ~p\n", [Enc]))); 
	_ when ErrString =/= undefined ->
	    ?fatal_error(State, ErrString)
  end;
unicode_incomplete_check([Bytes,State | _], ErrString) when is_list(Bytes), ErrString =/= undefined ->
    ?fatal_error(State, ErrString).


%%----------------------------------------------------------------------
%% Function  : check_uri(Uri, CL) -> Result
%% Parameters: Uri = string()
%%             CL = string()
%% Result    : {atom(), string()}
%% Description: 
%%----------------------------------------------------------------------
check_uri("http://" ++ _ = Url, _CL) ->
    {http, Url};
check_uri("file://" ++ Path, _CL) ->
    {file, Path};
check_uri(Path, CL) -> % ordinary filepath other URI's not supported yet
    %% "file://" already removed when current_location set 
    Tag = get_uri_tag(CL),
    case filename:pathtype(Path) of
	relative ->
	    case Tag of 
		false ->
		    {file, filename:join(CL, Path)};
		T ->
		    {T, CL ++ "/" ++ Path}
	    end;
	absolute ->
	    case Tag of
		false ->
		    {file, filename:absname(Path)};
		T ->
		    {T, CL ++ "/" ++ Path}
	    end;
	volumerelative -> % only windows
	    case Tag of
		false ->
		    [Vol | _] = re:split(CL, ":", [{return,list}]),
		    {file, filename:join(Vol ++ ":", Path)};
		T ->
		    {T, CL ++ "/" ++ Path}
	    end  
    end.

%%----------------------------------------------------------------------
%% Function  : get_uri_tag(Uri) -> Result
%% Parameters: Uri = string()
%% Result    : true |false
%% Description: http / file is the only supported URI for the moment
%%----------------------------------------------------------------------
get_uri_tag(Uri) ->
    case re:split(Uri, "://", [{return,list}]) of
	[Tag, _] ->
	    list_to_atom(Tag);
	[_] ->
	    false
    end.

%%----------------------------------------------------------------------
%% Function  : http_get_file(Host, Port, Key) -> Result
%% Parameters: Host = string()
%%             Port = integer()
%%             Key = string()
%% Result    : string()
%% Description: 
%%----------------------------------------------------------------------
http_get_file(Host, Port, Key) ->
    ConnectTimeOut = 10000,
    SendTimeout = 10000,
    FilenameTempl = filename:basename(Key),

    {Filename, FD} = create_tempfile(FilenameTempl),
    Socket = create_connection(Host, Port, ConnectTimeOut),
    Request = "GET " ++ Key ++ " HTTP/1.0\r\n\r\n",   
    
    case gen_tcp:send(Socket, Request) of
	ok ->
	    try 
		receive_msg(Socket, FD, true, SendTimeout)
	    catch
		throw:{error, Error} -> 
		    file:close(FD),	 	
		    file:delete(Filename),		    
		    throw({error, Error})
	    end;
	{error, _Reason} ->
	    file:close(FD),	 	
	    file:delete(Filename),
	    throw({error, lists:flatten(io_lib:format("Couldn't fetch http://~s:~p/~s",
						      [Host, Port, Key]))})
    end,
    file:close(FD),	 	
    Filename.

%%----------------------------------------------------------------------
%% Function  : receive_msg(Socket, FD, WaitForHeader, Timeout) -> Result
%% Parameters: Socket = io_device()
%%             FD = io_device()
%%             WaitForHeader = boolean()
%%             Timeout = integer()
%% Result    : ok
%% Description: 
%%----------------------------------------------------------------------
receive_msg(Socket, FD, WaitForHeader, Timeout) ->
    receive 
	{tcp_closed, Socket} ->
	    ok;
	{tcp, Socket, Response} when WaitForHeader == false  ->
	    file:write(FD, Response),
	    receive_msg(Socket, FD, WaitForHeader, Timeout);
	{tcp, Socket, Response} ->
	    MsgBody = remove_header(Response),
	    file:write(FD, MsgBody),
	    receive_msg(Socket, FD, false, Timeout);
	{tcp_error, Socket, _Reason} ->
	    gen_tcp:close(Socket),
	    throw({error, "http connection failed"})
    after Timeout ->
	    gen_tcp:close(Socket),
	    throw({error, "http connection timedout"})
    end.


remove_header(<<"\r\n\r\n", MsgBody/binary>>) ->
    MsgBody;
remove_header(<<_C, Rest/binary>>) ->
    remove_header(Rest).

%%----------------------------------------------------------------------
%% Function  : create_connection(Host, Port, Timeout) -> Result
%% Parameters: Host = string()
%%             Port = integer()
%%             Timeout = integer()
%% Result    : io_device()
%% Description: 
%%----------------------------------------------------------------------
create_connection(Host, Port, Timeout) ->
    case gen_tcp:connect(Host, Port,[{packet,0}, binary, {reuseaddr,true}], Timeout) of
	{ok,Socket} ->
	    Socket;
	{error, Reason} ->
	    throw({error, lists:flatten(io_lib:format("Can't connect to ~s:~p ~p\n", 
						      [Host, Port, Reason]))})
    end.

%%----------------------------------------------------------------------
%% Function  : http(Url) -> Result
%% Parameters: Url = string()
%% Result    : {Host, PortInt, Key}
%% Description: 
%%----------------------------------------------------------------------
http("http://" ++ Address) ->
    case string:tokens(Address, ":") of
	[Host, Rest] ->
	    %% At his stage we know that address contains a Port number.
	    {Port, Key} = split_to_slash(Rest, []),
	    case catch list_to_integer(Port) of
		PortInt when is_integer(PortInt) ->
		    {Host, PortInt, Key};
		_ ->
		    throw({error, "Malformed key; port not an integer, should be http://Host:Port/path or http://Host/path"})
	    end;
	[Address] ->
	    %% Use default port
	    {Host, Key} = split_to_slash(Address, []),
	    {Host, ?HTTP_DEF_PORT, Key};
	_What ->
	    throw({error, "Malformed key; should be http://Host:Port/path or http://Host/path"})
    end.

%%----------------------------------------------------------------------
%% Function  : split_to_slash(String, Acc) -> Result
%% Parameters: String = string()
%%             Acc = string()
%% Result    : {string(), string()}
%% Description: 
%%----------------------------------------------------------------------
split_to_slash([], _Acc) ->
    throw({error, "No Key given Host:Port/Key"});
split_to_slash([$/|Rest], Acc) ->
    {lists:reverse(Acc), [$/|Rest]};
split_to_slash([H|T], Acc) ->
    split_to_slash(T, [H|Acc]).


%%----------------------------------------------------------------------
%% Function  : create_tempfile(Template) -> Result
%% Parameters: Template = string()
%% Result    : string()
%% Description: 
%%----------------------------------------------------------------------
create_tempfile(Template) ->
    TmpDir = 
	case os:type() of
	    {unix, _} ->
		case file:read_file_info("/tmp") of
		    {ok, _} ->
			"/tmp";
		    {error,enoent} ->
			throw({error, "/tmp doesn't exist"})
		end;
	    {win32, _} ->
		case os:getenv("TMP") of
		    false ->
			case os:getenv("TEMP") of
			    false ->
				throw({error, "Variabel TMP or TEMP doesn't exist"});
			    P2 ->
				P2
			end;
		    P1 -> 
			P1
		end
	end,
    TmpNameBase = filename:join([TmpDir, os:getpid() ++ Template ++ "."]),
    create_tempfile_1(TmpNameBase, 1).

create_tempfile_1(TmpNameBase, N) ->
    FileName = TmpNameBase ++ integer_to_list(N),
    case file:open(FileName, [write, binary])  of
	{error, _Reason} ->
	    create_tempfile_1(TmpNameBase, N+1);
	{ok, FD} ->
	    {FileName, FD}
    end.
    

%%----------------------------------------------------------------------
%% Function  : filter_endtag_stack(EndTagStack) -> Result
%% Parameters: EndTagStack = [{term(), string(), string(), 
%%                             term(), nslist(), nslist()}]
%% Result    : [string()]
%% Description: Returns a stack with just local names.
%%----------------------------------------------------------------------
filter_endtag_stack(EndTagStack) ->
    filter_endtag_stack(EndTagStack,[]).

filter_endtag_stack([], Acc) ->
    lists:reverse(Acc);
filter_endtag_stack([{_,_,N,_,_,_}| Ts], Acc) ->
    filter_endtag_stack(Ts, [N |Acc]).


%%----------------------------------------------------------------------
%% Function  : format_error(Tag, State, Reason) -> Result
%% Parameters: Tag = atom(), 
%%             State = xmerl_sax_parser_state()
%%             Reason = string()
%% Result    : {atom(), {string(), string(), integer()}, string(), [string()], event_state()}
%% Description: Format the resulting error tuple
%%----------------------------------------------------------------------
format_error(Tag, State, Reason) ->
    {Tag, 
     {
       State#xmerl_sax_parser_state.current_location,
       State#xmerl_sax_parser_state.entity,
       State#xmerl_sax_parser_state.line_no
      },
     Reason,
     filter_endtag_stack(State#xmerl_sax_parser_state.end_tags), 
     State#xmerl_sax_parser_state.event_state}.


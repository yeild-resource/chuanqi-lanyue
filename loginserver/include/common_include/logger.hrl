-ifndef(__LOGGER_HRL__).
-define(__LOGGER_HRL__, 1).



-define(DEBUG(Tag, Format, Args),
  logger:debug_msg(Tag, ?MODULE, ?LINE, Format, Args)).

-define(PRINT(What),
  logger:debug_msg(my_print, ?MODULE, ?LINE, "My print's ~p is: ~p", [??What, What])).

-define(DEBUG(Tag, Format),
  logger:debug_msg(Tag, ?MODULE, ?LINE, Format, [])).

-define(INFO(Tag, Format, Args),
  logger:info_msg(Tag, ?MODULE, ?LINE, Format, Args)).

-define(INFO(Tag, Format),
  logger:info_msg(Tag, ?MODULE, ?LINE, Format, [])).

-define(WARNING(Tag, Format, Args),
  logger:warning_msg(Tag, ?MODULE, ?LINE, Format, Args)).

-define(WARNING(Tag, Format),
  logger:warning_msg(Tag, ?MODULE, ?LINE, Format, [])).

-define(ERR(Tag, Format, Args),
  logger:error_msg(Tag, ?MODULE, ?LINE, Format, Args)).

-define(ERR(Tag, Format),
  logger:error_msg(Tag, ?MODULE, ?LINE, Format, [])).

-define(CRITICAL(Tag, Format, Args),
  logger:critical_msg(Tag, ?MODULE, ?LINE, Format, Args)).

-define(CRITICAL(Tag, Format),
  logger:critical_msg(Tag, ?MODULE, ?LINE, Format, [])).

-define(EXCEPTION_LOG(Type, What, Fun, Args),
  ?ERR(exception, "~nexception happened when call function: ~w~n"
                  "    arguments: ~w~n"
                  "    type: ~w, what: ~w~n"
                  "    stack trace: ~w~n~n",
       [Fun, Args, Type, What, erlang:get_stacktrace()])).

-endif.

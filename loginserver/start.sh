cd ./config
erl -pa ../ebin -sname loginserver -setcookie loginserver -detached -s server start

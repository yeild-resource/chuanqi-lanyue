cur_path=$(cd `dirname $0`; pwd)
cd $cur_path
cd ./config
erl -pa ../ebin -sname loginserver -setcookie loginserver -detached -s server start
echo 'loginserver started'

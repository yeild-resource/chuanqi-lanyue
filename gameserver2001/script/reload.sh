LOCAL_IP=192.168.1.28

cd ../config

erl -name reload@$LOCAL_IP -pa ../ebin -setcookie $LOCAL_IP -s hot_reload reload -arg $1 zhangchao_gs@$LOCAL_IP -s init stop > ../log/reload.log

cd ..

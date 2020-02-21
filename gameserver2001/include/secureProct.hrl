-define(Max_PassWordLen, 12).%%密码的最大长度

-define(SetPassWord_Success, 0).%%密码设置、修改成功
-define(SetPassWord_OldPassError, -1).%%老的密码错误
-define(SetPassWord_TooLong, -2).%%密码太长


-define(Authrity_Success, 0).%%密码输入成功
-define(Authrity_Failed, -1).%%密码校验失败
-define(Authrity_NotSet, -2).%%密码锁没设置
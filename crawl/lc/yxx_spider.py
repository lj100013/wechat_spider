def login(text):
    def decorator(func):
        def wrapper(*args, **kwargs):
            try:
                user = text.split("|")[0]
                password = text.split("|")[1]
                if user == "yuxunxing" and password != "1234":
                    print("无效密码！！！！！")
                elif user == "yuxunxing" and password == "1234":
                    print("登入成功！！！！！")
                    return func(*args,**kwargs)
                else:
                    print("无效账号！！！！！")
            except:
                print("输入格式不正确")
        return wrapper
    return decorator



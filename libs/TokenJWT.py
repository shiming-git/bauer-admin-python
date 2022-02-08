import time
import jwt


class Token():
    def __init__(self, alg="HS256"):
        self.alg = alg
        self.key = "eyJhbGciOiAiSFMyNTYiLCAidHlwIjogIkpXVCJ9"

    """
    加密
    """

    def encryption(self, payload):
        token_dict = {
            'time': int(time.time() * 1000000),
            'data': payload
        }
        headers = {
            'alg': self.alg,  # 声明所使用的算法
        }

        # 调用jwt库,生成json web token
        jwt_token = jwt.encode(token_dict,  # payload, 有效载体
                               self.key,  # 进行加密签名的密钥
                               algorithm=self.alg,  # 指明签名算法方式, 默认也是HS256
                               headers=headers  # json web token 数据结构包含两部分, payload(有效载体), headers(标头)
                               )
        # print("Token 加密==>>", jwt_token)
        return jwt_token, token_dict

    """
    解密
    """

    def decrypt(self, token):
        data = None
        try:
            data = jwt.decode(token, self.key, algorithms=[self.alg])
        except Exception as e:
            # 如果 jwt 被篡改过; 或者算法不正确; 如果设置有效时间, 过了有效期; 或者密钥不相同; 都会抛出相应的异常
            print(e)
        # 解析出来的就是 payload 内的数据
        # print("Token 解密==>>", data)
        return data

import tensorflow as tf
import string
import os

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'


def get_captcha_image(png_path):
    # 验证码路径
    image_value = tf.read_file(png_path)
    # 创建图片解码器
    image = tf.image.decode_png(image_value, channels=3)
    return image

def load_model(png_path):
    image = get_captcha_image(png_path)
    with tf.Session() as sess:
        image = image.eval().reshape(1, 80 * 240 * 3)
        saver = tf.train.import_meta_graph('./model/captcha-9900.meta')
        saver.restore(sess, tf.train.latest_checkpoint("./model/"))
        # 获取权重和偏置
        graph = tf.get_default_graph()
        w = graph.get_tensor_by_name("model/w_:0")
        b = graph.get_tensor_by_name("model/b_:0")
        # 进行全连接层计算
        y = tf.matmul(tf.cast(image, tf.float32), w) + b
        y_p = tf.argmax(tf.reshape(y, [1, 5, 26]), 2)
        # print("获取模型权重", sess.run(w))
        # print("获取模型偏置", sess.run(b))
        print("#######################################")
        label = sess.run(y_p).tolist()[0]
        num_label = dict(enumerate(list(string.ascii_lowercase)))
        p_label = "".join([num_label[i] for i in label])
        print("生成模型的预测值", p_label)
        return p_label


if __name__ == "__main__":
    png_path = "./0.png"
    y_p = load_model(png_path)
    os.remove(png_path)
#with open("./err_user",encoding="gbk")as f1:
#    user1 = [u.split(",")[0] for u in f1.readlines()]
#with open("./nowscrawl/spiders/user.txt",encoding="utf-8")as f2:
#    user2 = [u.strip() for u in f2.readlines()]
#s_url = [u for u in user2 if u not in user1]
#for u3 in s_url:
#    print(u3)
#    with open("./user.txt", "a",encoding="utf-8")as f3:
#        f3.write(u3+"\n")

import jieba
import jieba.analyse

def words2vec(words1=None, words2=None):
    v1 = []
    v2 = []
    tag1 = jieba.analyse.extract_tags(words1, withWeight=True)
    tag2 = jieba.analyse.extract_tags(words2, withWeight=True)
    tag_dict1 = {i[0]: i[1] for i in tag1}
    tag_dict2 = {i[0]: i[1] for i in tag2}
    merged_tag = set(tag_dict1.keys()) | set(tag_dict2.keys())
    for i in merged_tag:
        if i in tag_dict1:
            v1.append(tag_dict1[i])
        else:
            v1.append(0)
        if i in tag_dict2:
            v2.append(tag_dict2[i])
        else:
            v2.append(0)
    return v1, v2


def cosine_similarity(vector1, vector2):
    dot_product = 0.0
    normA = 0.0
    normB = 0.0
    for a, b in zip(vector1, vector2):
        dot_product += a * b
        normA += a ** 2
        normB += b ** 2
    if normA == 0.0 or normB == 0.0:
        return 0
    else:
        return round(dot_product / ((normA**0.5)*(normB**0.5)) * 100, 2)

def cosine(str1, str2):
    vec1, vec2 = words2vec(str1, str2)
    return cosine_similarity(vec1, vec2)


def block_sim(block1, n_content):
    block1=block1.replace('\'','').replace('\"','').replace('&quot;','')
    blocks1 = block1.split(' ')
    n_content=n_content.replace('\'','').replace('\"','')
    blocks2 = n_content.split(' ')

    words1 = set()
    words2 = set()
    all_words = set()
    common_count = 0

    for word in blocks1:
        words1.add(word)
        all_words.add(word)

    for word in blocks2:
        words2.add(word)
        all_words.add(word)

    for word2 in words2:
        if word2 in words1:
            common_count += 1
    score = common_count/len(all_words)
    return score

if __name__ == '__main__':
    s = 'abc123xyz'
    # a _> x, b_> y, c_> z，字符映射加密
    print(str.maketrans('abcxyz', 'xyzabc'))
    # translate把其转换成字符串
    print(s.translate(str.maketrans('abcxyz', 'xyzabc')))
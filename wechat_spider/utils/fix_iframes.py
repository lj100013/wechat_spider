#coding:utf-8

def fix_iframe(content,iframes):
    for frame in iframes:
        vids = frame.split("&")
        if len(vids) < 1:
            continue
        vid = vids[-1]
        frame = frame.replace("&", "&amp;")
        vedios = frame.split("?")
        if len(vedios) < 1:
            continue
        vedio_str = vedios[1]
        original_str = 'data-src="https://v.qq.com/iframe/preview.html?' + vedio_str + '"'
        replace_str = 'src="https://v.qq.com/txp/iframe/player.html?' + vid + '" ' + 'width="580" height="280"'
        content = content.replace(original_str, replace_str)
    return content
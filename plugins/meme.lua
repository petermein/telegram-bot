
function getMeme(url,top,bottom)
    local murl = "http://memecaptain.com/g?u="..url.."&t1="..urlencode(top).."&t2="..urlencode(bottom)
    b = http.request(murl)
    local meme = json:decode(b)
    return meme.imageUrl
end

function run(msg, matches)
    var_1, var_2, var_3 = string.match(msg.text, "!meme (.+)|(.+)|(.+)")
    print(var_1)
    print(var_2)
    print(var_3)
    local image = getGoogleImage(var_1)
    local meme = getMeme(image,var_2,var_3)
    local receiver = get_receiver(msg)
    local file_path = download_to_file(meme)
    send_photo(receiver, file_path, ok_cb, false)
    return
end

return {
    description = "Make a meme",
    usage = "!meme [img search] | [top line] | [bottom line]",
    patterns = {"^!meme (.+)|(.+)|(.+)$"},
    run = run
}


-- Idea by https://github.com/asdofindia/telegram-bot/
-- See http://api.giphy.com/

function get_random_top()
  local api_key = "dc6zaTOxFJmzC" -- public beta key
  local b = http.request("http://api.giphy.com/v1/gifs/trending?api_key="..api_key)
  local images = json:decode(b).data
  local i = math.random(0,#images)
  return images[i].images.downsized.url
end

function search(text)
  local api_key = "dc6zaTOxFJmzC" -- public beta key
  url = "http://api.giphy.com/v1/gifs/search?q="..urlencode(text).."&api_key="..api_key
  print(url)
  b = http.request("http://api.giphy.com/v1/gifs/search?q="..urlencode(text).."&api_key="..api_key)
  local images = json:decode(b).data
  math.randomseed(os.time())
  print(images)
  print(#images)
  local i = math.random(0,#images)
  print(i)
  return images[i].images.downsized.url
end

function run(msg, matches)
  -- If no search data, a cat gif will be sended
  -- Because everyone loves pussies
  if matches[1] == "!gif" or matches[1] == "!giphy" then
    gif_url = get_random_top()
  else
    gif_url = search(matches[1])
  end

  local receiver = get_receiver(msg)
  send_document_from_url(receiver, gif_url)
  return
end

return {
  description = "GIFs from telegram with Giphy API",
  usage = {
    "!gif (term): Search and sends GIF from Giphy. If no param, sends a trending GIF."
    },
  patterns = {
    "^!gif$",
    "^!gif (.*)",
    "^!giphy (.*)",
    "^!giphy$"
  },
  run = run
}
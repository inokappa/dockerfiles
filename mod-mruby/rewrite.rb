#
hi = Apache::Request.new.headers_in
agent = hi["User-Agent"]
#
def go_redirect(redirect_path)
  r = Apache::Request.new()
  s = Apache::Server.new()
  r.filename = s.document_root + redirect_path
  Apache.return(Apache::OK)
end
#
if agent.include?("Mac") then
  go_redirect("/iphone.html")
elsif agent.include?("Android") then
  go_redirect("/android.html")
else
  Apache.return(Apache::DECLINED)
end

Page.fixture(:new) {{
  :path => /\w+/.gen,
  :password => BCrypt::Password.create(/\w+/.gen),
  :state => Page.state[:new],
  :css => Theme.default.css,
  :body => Page.default_body,
  :theme => Theme.default,
}}


Page.fixture(:general) {{
  :path => /\w+/.gen,
  :password => BCrypt::Password.create(/\w+/.gen),
  :state => Page.state[:new],
  :css => Theme.default.css,
  :body => Page.default_body,
  :theme => Theme.pick,
}}


Theme.fixture {{
  :name => /\w+/.gen,
  :css => "#{/\w+/.gen}\n#{/\w+/.gen}\n#{/\w+/.gen}\n#{/\w+/.gen}\n",
}}


puts "Generating test models..."

3.times {Page.gen(:new)}
5.times {Theme.gen}
10.times {Page.gen(:general)}

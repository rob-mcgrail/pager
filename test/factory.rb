User.fix {{
  :username => /\w+/.gen,
  :tweets   => 500.of {Tweet.make}
}}

Tweet.fix {{
  :message => /[:sentence:]/.gen[0..140],
  :tags    => (0..10).of {Tag.make}
}}

Tag.fix {{
  :name => /\w+/.gen
}}

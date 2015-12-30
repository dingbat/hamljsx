# Haml :heart: JSX

With this gem you can inline HAML in JSX, as long as it's between the `(~` and `~)` delimeters.

```javascript
var section = ...
var button = ...
return (~
  %div(key={"section-"+section.id})
    .section-box
      .section-btn
        {button}
      %SomeOtherClass(schedule={this.state.store.schedule}
~);
```

File extension should be `.js.jsx.haml`.

Still in serious beta.

### Usage

Add the following line to your gemfile:

```ruby
gem 'hamljsx'
```

Requires a server restart.
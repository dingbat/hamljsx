# Haml :heart: JSX

With this gem you can inline HAML in JSX, placing it between the `(~` and `~)` delimeters.

```javascript
var section = ...
var button = ...
return (~
  .(key={"section-"+section.id})
    .section-box
      .section-btn
        {button}
      %SomeOtherClass(schedule={this.state.store.schedule})
~);
```

* File extension should be `.js.jsx.haml`.
* Use `{...}` to embed javascript into the HAML, just like JSX.
* Use `%tag(key="val" key2="val2")` syntax for element properties, not `%tag{key: "val", :key2 => "val2"}` syntax (this conflicts with JSX embedding).
* For dynamic classes, there's no need to use `className`, just use the `class` property: `%table(class={...})`.
* Slight `div` optimization on HAML! Use `.` even when there is no class name, instead of having to use `%div`.
* Still in serious beta!

### Usage

Add the following line to your gemfile:

```ruby
gem 'hamljsx'
```

Requires a server restart.
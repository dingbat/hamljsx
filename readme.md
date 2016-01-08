# Haml :heart: JSX

With this Rails gem you can inline HAML in JSX by putting it between the `(~` and `~)` delimeters.

File extensions should be `.js.jsx.haml`.

Use `{...}` to embed javascript into the HAML, just like JSX.

```javascript
var section = ...
var button = ...
return (~
  .section-box(key={"section-"+section.id})
    .section-button
      {button}
    %SomeOtherClass(schedule={this.state.store.schedule})
~);
```

### Limitations

* Use `%tag(key="val" key2="val2")` syntax for element properties, not `%tag{key: "val"}` or `%tag{:key => "val2}` syntax (this conflicts with JS embedding).
* `{` or `}` cannot be used inside the embed, as this isn't parsed correctly yet. For example, you can't embed `{if (a) { return b; }}` or have a property like `style={{color:"blue", width:50}}` in your HAML. Put these expressions into variables and embed those instead. (This seems like better practice anyway.)
* Still in serious beta!

### Optimizations

* For dynamic classes, there's no need to use `className`, just use the `class` property: `%table(class={...})`.
* Slight `div` optimization for HAML –– use `.` even when there is no class name, instead of having to use `%div`:
  
  ```javascript
  .
    .one-div
    .(class="two-div")
  ```

* The JSX spacing standard is made more consistent with the HAML standard, so that:

  ```javascript
  %p
    There are
    {a.length}
    elements
  ```
  produces `There are 6 elements` instead of `There are6elements` (which JSX would produce given `(<p>There are {a.length} elements</p>)`).

## Installation

Add the following line to your gemfile:

```ruby
gem 'hamljsx'
```

Requires a `bundle` and a server restart.
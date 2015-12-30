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

Still in serious beta.
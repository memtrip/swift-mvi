## MVI Design pattern
A swift example of MVI (model view intent), a design pattern gaining momentum amongst Android developers.

### Unidirectional data flow
The design pattern champions a unidirectional data flow. The `MxViewModel` observes on `MxIntent` events that are emitted by ui interactions, an action is performed for each intent that is received, each action returns an `MxResult`, this result is reduced into an `MxViewState` - an immutable representation of a screen. The ui observes on `MxViewState` and renders the screen when a new state is received.

### The Rx flow
The entire design pattern is driven by a single [rx Subject](http://reactivex.io/documentation/subject.html). The `Subject` observes on the `MxIntent` events that are emitted from RxCocoa ui elements. The ui observes on the result of the operations performed on the `Subject`

```
                                           Observe the MxIntent events
                                  +------+ that are emitted from ui
                                  |      | interactions.
                    +-------------+  UI  ●-------------+
                    |             |      |             ▼  MxIntent
                    |             +--+---+             |  * Perform action
                    |                |                 ▼  MxResult
                    |                |                 |  * Map to representation
                    |                |                 |    of a screen
                    ▲                |                 ▼  MxViewState
                    |                |                 |
                    |                |                 |
                    |                |                 |
                    |          +-----*-------+         |
                    |          |             |         |
                    +----------●  ViewModel  +---------+
Observe the MxViewState events |             |
that are emitted as the result +-------------+
of an intent driven action.

● Observe events
▼ Transform Observable type
```


### More on MVI
- http://hannesdorfmann.com/android/model-view-intent
- https://github.com/memtrip/android-mvi
- https://github.com/cyclejs/cyclejs
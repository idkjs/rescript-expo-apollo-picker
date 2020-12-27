open ReactNative
open ListStarships
type starship = ListStarships.t_allStarships_starships
@react.component
let make = (~starshipId: string, ~onStarshipChange) => {
  Js.log("New starshipId: " ++ starshipId)
  let queryResult = ListStarships.use()

  {
    switch queryResult {
    | {loading: true, data: None} => <Text> {"Loading"->React.string} </Text>
    | {data: Some(data)} =>
      let starships: array<ListStarships.t_allStarships_starships> =
        switch data.allStarships {
        | Some(allStarships) => allStarships.starships
        | None => None
        }
        ->Belt.Option.getWithDefault([])
        ->Belt.Array.keepMap(e => e)
      // ReactNativePickerIOS doesnt work on web
      <>
        <ReactNativePickerIOS
          selectedValue=starshipId onValueChange=onStarshipChange mode=#dropdown>
          {Belt.Array.mapWithIndex(starships, (i, starship) =>
            <ReactNativePickerIOS.Item
              key={i->string_of_int} label=?{starship.name} value={starship.id}
            />
          )->React.array}
        </ReactNativePickerIOS>
      </>
    | {loading: false, data: None} => <p> {"Nothing to see here"->React.string} </p>
    }
  }
}

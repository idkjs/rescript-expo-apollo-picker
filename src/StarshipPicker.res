open ReactNative
open ListStarships
type starship = ListStarships.t_allStarships_starships
@react.component
let make = (~starshipId: string, ~onStarshipChange) => {
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

      <>
        <ReactNativePicker selectedValue=starshipId onValueChange=onStarshipChange mode=#dropdown>
          {React.array(
            starships->Belt.Array.map(_, (starship: starship) => {
              <ReactNativePicker.Item
                key={starship.id} label=?{starship.name} value={starship.id}
              />
            }),
          )}
        </ReactNativePicker>
      </>
    | {loading: false, data: None} => <> <Text> {"Nothing to see here"->React.string} </Text> </>
    }
  }
}

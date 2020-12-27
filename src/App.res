
module RootComponent = {
  open ReactNative
  open AppStyles
  let defaultStarshipId = "c3RhcnNoaXBzOjM="

  open GetStarship

  @react.component
  let make = () => {
    let (starshipId, setStarshipId) = React.useState(_ => defaultStarshipId)
    let queryResult = GetStarship.use({id: starshipId})

    switch queryResult {
    | {error: Some(error)} => {
        Js.log2("Some(error)", error.message)
        <> <Text> {error.message->React.string} </Text> </>
      }
    | {loading, data: Some(data)} =>
      switch data.starship {
      | None => React.null
      | Some(starship) =>
        <View style={styles["container"]}>
          <View style={styles["section"]}>
            <StarshipPicker
              starshipId onStarshipChange={(string, _) => setStarshipId(_ => string)}
            />
            // ReactNativePickerIOS doesnt work on web
            // <StarshipPickerIOS
            //   starshipId onStarshipChange={(string, _) => setStarshipId(_ => string)}
            // />
          </View>
          {loading ? <Loading /> : <StarshipDetails loading starship />}
        </View>
      }
    | {data: None, error: None, loading} => <>
        <View style={styles["container"]}> {loading ? <Loading /> : React.null} </View>
      </>
    }
  }
}
@react.component
let make = () => {
  <ApolloClient.React.ApolloProvider client=Client.client> <RootComponent /> </ApolloClient.React.ApolloProvider>
}
let default = make

open ReactNative
open AppStyles

// type for one film
type rec film = GetStarship.GetStarship.GetStarship_inner.t_starship_filmConnection_films

module Film = {
  @react.component
  let make = (~id, ~title="") => <Text key={id}> {("- " ++ title)->React.string} </Text>
}
// helper function because this is so long to write
let dfk = arr => arr->Belt.Option.getWithDefault([])->Belt.Array.keepMap(e => e)

@react.component
let make = (~loading, ~starship: GetStarship.GetStarship.GetStarship_inner.t_starship) => {
  loading
    ? <> <Loading /> </>
    : <>
        <View style={styles["section"]}>
          {starship.name
          ->Belt.Option.map(name =>
            <Text style={styles["starshipName"]}> {name->React.string} </Text>
          )
          ->Belt.Option.getWithDefault(React.null)}
          {starship.model
          ->Belt.Option.map(model =>
            <Text style={styles["starshipModel"]}> {model->React.string} </Text>
          )
          ->Belt.Option.getWithDefault(React.null)}
        </View>
        <View style={styles["section"]}>
          <Text style={styles["label"]}> {"Operational abilities"->React.string} </Text>
          {starship.crew
          ->Belt.Option.map(crew =>
            <Text> {("- " ++ crew ++ " crew members")->React.string} </Text>
          )
          ->Belt.Option.getWithDefault(React.null)}
          {starship.consumables
          ->Belt.Option.map(consumables =>
            <Text> {("- " ++ consumables ++ " without restocking")->React.string} </Text>
          )
          ->Belt.Option.getWithDefault(React.null)}
        </View>
        <View>
          <Text style={styles["label"]}> {"Ship attributes"->React.string} </Text>
          {starship.length
          ->Belt.Option.map(length =>
            <Text> {("- " ++ Js.Float.toString(length) ++ "m long")->React.string} </Text>
          )
          ->Belt.Option.getWithDefault(React.null)}
          {starship.costInCredits
          ->Belt.Option.map(costInCredits =>
            <Text> {("- " ++ Js.Float.toString(costInCredits) ++ " credits")->React.string} </Text>
          )
          ->Belt.Option.getWithDefault(React.null)}
        </View>
        <View style={styles["section"]}>
          <Text style={styles["label"]}> {"Manufacturers"->React.string} </Text>
          {React.array(Array.map(manufacturer => {
              <Text key={manufacturer}> {("- " ++ manufacturer)->React.string} </Text>
            }, starship.manufacturers->dfk))}
        </View>
        <View style={styles["section"]}>
          <Text style={styles["label"]}> {"Appeared in"->React.string} </Text>
          {React.array(Array.map((film: film) => {
              <Film id=film.id title=?{film.title} />
            }, starship.filmConnection->Belt.Option.flatMap(fc => fc.films)->dfk))}
        </View>
      </>
}

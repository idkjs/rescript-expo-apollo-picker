open ReactNative
let styles = {
  open Style
  StyleSheet.create({
    "loadingContainer": style(~flex=1., ~justifyContent=#center, ~alignItems=#center, ()),
    "container": style(~flex=1., ~justifyContent=#center, ~paddingHorizontal=50.->dp, ()),
    "label": style(
      ~marginBottom=2.->dp,
      ~fontSize=12.,
      ~fontWeight=#bold,
      ~textTransform=#uppercase,
      (),
    ),
    "section": style(~marginVertical=12.->dp, ()),
    "starshipName": style(~fontSize=32., ~fontWeight=#bold, ()),
    "starshipModel": style(~fontStyle=#italic, ()),
  })
}

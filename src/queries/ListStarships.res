%graphql(`
    query ListStarships {
        allStarships {
            starships {
                id
                name
            }
        }
    }
`)

import { gql } from 'apollo-server'

const typeDefs = gql`
  type Query {
    findGames: [Game]
  }
`

export default typeDefs

import { gql } from 'apollo-server'

const typeDefs = gql`
  type Game {
    id: ID!
    name: String!
    url: String!
  }
`

export default typeDefs

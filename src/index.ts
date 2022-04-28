import { ApolloServer } from 'apollo-server'

import { resolvers } from './resolvers'
import { typeDefsList } from './schemas'

const server = new ApolloServer({
  typeDefs: typeDefsList,
  resolvers,
})

server.listen().then(({ url }) => {
  console.log(`The apollo server is running at ${url}.`);
})

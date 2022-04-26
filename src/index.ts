import {foo} from './foo'

const main = async (): Promise<void> => {
    console.log(await foo())
}
main()

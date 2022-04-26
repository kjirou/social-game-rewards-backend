const foo = async (): Promise<string> => 'FOO'
const main = async (): Promise<void> => {
    console.log(await foo())
}
main()

package main

import (
	"fmt"
	"os"
)

func main() {
	todos := Todos{}
	storage := NewStorage[Todos]("todos.json")
	err := storage.Load(&todos)

	if err != nil {
		fmt.Println("Error, storage load have not been successfuly run!")
		os.Exit(1)
	}

	CmdFlags := NewCmdFlags()
	CmdFlags.Execute(&todos)
	err = storage.Save(todos)

	if err != nil {
		fmt.Println("Error, storage save have not been successfuly run!")
		os.Exit(1)
	}
}

package main

import (
	"flag"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type CmdFlags struct {
	Add    string
	Del    int
	Edit   string
	Toggle int
	List   bool
}

func NewCmdFlags() *CmdFlags {
	cf := CmdFlags{}

	flag.StringVar(&cf.Add, "add", "", "Add a new todo task")
	flag.StringVar(&cf.Edit, "edit", "", "Edit the todo by index & specify a new title. id:new_title")
	flag.IntVar(&cf.Del, "del", -1, "Delete todo specified by index")
	flag.IntVar(&cf.Toggle, "toggle", -1, "Specify a todo by index to toggle")
	flag.BoolVar(&cf.List, "list", false, "List all todos")

	flag.Parse()

	return &cf
}

func (cf *CmdFlags) Execute(todos *Todos) {
	switch {
	case cf.List:
		todos.print()

	case cf.Add != "":
		todos.add(cf.Add)

	case cf.Edit != "":
		parts := strings.SplitN(cf.Edit, ":", 2)

		if len(parts) != 2 {
			fmt.Println("Error, invalid format for edit. Please use id:new_title!")
			os.Exit(1)
		}

		index, err := strconv.Atoi(parts[0])

		if err != nil {
			fmt.Println("Error: invalid index for edit!")
			os.Exit(1)
		}

		err = todos.edit(index, parts[1])

		if err != nil {
			fmt.Println("Error, edit operation have not been successfuly run!")
			os.Exit(1)
		}

	case cf.Toggle != -1:
		err := todos.toggle(cf.Toggle)

		if err != nil {
			fmt.Println("Error, toggle operation have not been successfuly run!")
			os.Exit(1)
		}

	case cf.Del != -1:
		err := todos.delete(cf.Del)

		if err != nil {
			fmt.Println("Error, toggle operation have not been successfuly run!")
			os.Exit(1)
		}

	default:
		fmt.Println("Invalid command!")
	}
}

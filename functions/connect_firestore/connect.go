package connect_firestore

import (
	"fmt"
	"net/http"

	"cloud.google.com/go/firestore"
)

func ConnectFirestore(w http.ResponseWriter, r *http.Request) {
	projectId := "gcp-test-project-20230329"

	client, err := firestore.NewClient(r.Context(), projectId)
	if err != nil {
		fmt.Fprintf(w, "Failed to create client: %v", err)
		return
	}

	defer client.Close()

	iter := client.Collection("USER").Where("name", "==", "user").Documents(r.Context())

	users, err := iter.GetAll()
	if err != nil {
		fmt.Fprintf(w, "Failed to get documents: %v", err)
		return
	}

	for _, user := range users {
		fmt.Fprintf(w, "User: %v\n", user.Data())
	}

	fmt.Fprintf(w, "Complete!!")
}

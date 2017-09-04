package main

import (
	"encoding/json"
	"fmt"
	"os"
	"time"
)

type event struct {
	Records []struct {
		EventVersion         string `json:"EventVersion"`
		EventSubscriptionArn string `json:"EventSubscriptionArn"`
		EventSource          string `json:"EventSource"`
		Sns                  struct {
			SignatureVersion  string    `json:"SignatureVersion"`
			Timestamp         time.Time `json:"Timestamp"`
			Signature         string    `json:"Signature"`
			SigningCertURL    string    `json:"SigningCertUrl"`
			MessageID         string    `json:"MessageId"`
			Message           string    `json:"Message"`
			MessageAttributes struct {
				Test struct {
					Type  string `json:"Type"`
					Value string `json:"Value"`
				} `json:"Test"`
				TestBinary struct {
					Type  string `json:"Type"`
					Value string `json:"Value"`
				} `json:"TestBinary"`
			} `json:"MessageAttributes"`
			Type           string `json:"Type"`
			UnsubscribeURL string `json:"UnsubscribeUrl"`
			TopicArn       string `json:"TopicArn"`
			Subject        string `json:"Subject"`
		} `json:"Sns"`
	} `json:"Records"`
}

func main() {
	// os.Args[1] should always be the event
	event := event{}
	incomingEvent := os.Args[1]

	err := json.Unmarshal([]byte(incomingEvent), &event)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Printf("EXAMPLE SNS EVENT MESSAGE: %v\n", event.Records[0].Sns.Message)
	fmt.Printf("EXAMPLE SNS EVENT SUBJECT: %s\n", event.Records[0].Sns.Subject)
}

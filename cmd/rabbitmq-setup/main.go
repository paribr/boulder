// Copyright 2014 ISRG.  All rights reserved
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

package main

// This command does a one-time setup of the RabbitMQ exchange suitable
// for setting up a dev environment or Travis.

import (
	"flag"

	"github.com/letsencrypt/boulder/Godeps/_workspace/src/github.com/streadway/amqp"

	"github.com/letsencrypt/boulder/cmd"
)

var server = flag.String("server", "", "RabbitMQ Server URL")

func init() {
	flag.Parse()
}

// Constants for AMQP
const (
	monitorQueueName    = "Monitor"
	amqpExchange        = "boulder"
	amqpExchangeType    = "topic"
	amqpInternal        = false
	amqpExchangeDurable = true
	amqpQueueDurable    = false
	amqpDeleteUnused    = false
	amqpExclusive       = false
	amqpNoWait          = false
)

func main() {
	server := *server
	conn, err := amqp.Dial(server)
	cmd.FailOnError(err, "Could not connect to AMQP")
	ch, err := conn.Channel()
	cmd.FailOnError(err, "Could not connect to AMQP")

	err = ch.ExchangeDeclare(
		amqpExchange,
		amqpExchangeType,
		amqpExchangeDurable,
		amqpDeleteUnused,
		amqpInternal,
		amqpNoWait,
		nil)
	cmd.FailOnError(err, "Declaring exchange")

	_, err = ch.QueueDeclare(
		monitorQueueName,
		amqpQueueDurable,
		amqpDeleteUnused,
		amqpExclusive,
		amqpNoWait,
		nil)
	if err != nil {
		cmd.FailOnError(err, "Could not declare queue")
	}
}

extends CanvasLayer

var coins = 0

func _ready():

	var coinNodes = get_tree().get_nodes_in_group("coins")

	for coin in coinNodes:
		coin.coinCollected.connect(handleCoinCollected)

	$CoinsCollectedText.text = str(coins)


func handleCoinCollected():
	coins += 1
	$CoinsCollectedText.text = str(coins)

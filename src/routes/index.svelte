<style>
	h1 {
		text-align: center;
		margin: 0 auto;
		font-size: 2.8em;
		text-transform: uppercase;
		font-weight: 700;
	}

  h4 {
    text-align: right;
  }

  p {
    margin: 0
  }

	@media (min-width: 480px) {
		h1 {
			font-size: 4em;
		}
	}
</style>

<script context="module">
  export async function preload(page, session) {
    const res = await this.fetch('http://localhost:3033/orders')
    const orders = await res.json()
    return { orders }
  }
</script>

<script>
  import { onMount } from 'svelte'

  export let orders

  onMount(() => {
    setInterval(longPolling, 5000)
  })

  async function longPolling() {
    const res = await fetch('http://localhost:3033/orders')
    orders = await res.json()
  }

  async function cancelOrder(event) {
    const orderId = event.target.value
    console.log('cancelling order for id', orderId)
    await fetch(`http://localhost:3033/orders/${orderId}`, { method: 'DELETE' })
  }
</script>

<svelte:head>
	<title>Setel app</title>
</svelte:head>

<h1>My Orders</h1>
<a href="/new"><h4>Create New</h4></a>

{#each orders as order}
  <p>{order.id} {order.name} {order.status}</p>
  <button on:click={cancelOrder} value={order.id}>cancel</button>
{/each}

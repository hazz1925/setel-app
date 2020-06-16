<script>
  import { goto } from '@sapper/app';

  async function submit(e) {
    const formObj = getFormObject(e.target)
    const res = await fetch('http://localhost:3033/orders', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(formObj)
    })

    if (res.status === 201) {
      await goto('/')
    }
  }

  function getFormObject(form) {
    const formData = new FormData(form)
    const obj = {}
    formData.forEach((v, k) => {
      obj[k] = v
    })
    return obj
  }
</script>

<h1>New Order</h1>

<form on:submit|preventDefault={submit}>
  <label for="name">Name</label>
  <input name="name" type="text">
  <input type="submit" value="Submit">
</form>

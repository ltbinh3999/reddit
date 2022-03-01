<script lang="ts">
	export let posts;
</script>

<h1>Index</h1>

<div class="warper">
	{#each posts as { title, username, content }}
		<div class="card">
			<div>{title}</div>
			<div>{'by ' + username}</div>
			<div>{content}</div>
		</div>
	{/each}
</div>

<style>
	.card {
		border: 1px solid black;
		width: 50%;
	}
</style>

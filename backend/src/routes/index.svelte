<script lang="ts">
	export let posts;
</script>

<h1>Welcome to SvelteKit</h1>
<p>Visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to read the documentation</p>

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

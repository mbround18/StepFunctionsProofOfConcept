<template>
    <div>
        <h1>{{message}}</h1>
        <button v-on:click="delivery">Click Me</button>
    </div>
</template>

<script lang="ts">
    export default {
        name: "App",
        data() {
          return {
              message: "Hello World" 
          };
        },
        methods: {
            delivery() {
                const derp: any = {
                    apple: "Nested message with question mark"
                };
                console.log(derp?.apple);
            }
        }
    }
</script>

<style type="scss"  scoped>
    
h1 {
    color: purple;
}
</style>
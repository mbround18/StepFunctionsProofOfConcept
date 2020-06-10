<template>
    <div>
        <h1>{{message}}</h1>
        <button v-on:click="delivery">Click Me</button>
    </div>
</template>

<script lang="ts">
    import Axios from "axios";
    export default {
        name: "App",
        data() {
          return {
              message: "Hello World" 
          };
        },
        methods: {
            post() {
                Axios.post('')
            }
        }
    }
</script>

<style type="scss"  scoped>
    
h1 {
    color: purple;
}
</style>
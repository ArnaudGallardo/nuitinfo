<template>
    <div id="dashboard" class="page">
        <h1>Dashboard</h1>
        <div>
            <h2>Hello, {{userState.firstName}}</h2>

            <h2 class="title">La Nuit</h2>
            <counter></counter>

            <h2 class="title">Ton équipe</h2>
            <team></team>

            <h2 class="title">Toi</h2>
            <div>
                <div><span class="special">Email :</span> {{userState.email}}</div>
                <div class="special">Bio :</div>
                <div v-html="nl2br(biography)" class="bio"></div>
            </div>

            <router-link :to="{name: 'edit'}">Éditer mon profil</router-link>
        </div>
    </div>
</template>

<script>
    import Counter from '../elements/Counter.vue';
    import Team from '../elements/Team.vue';
    import user from '../stores/UserStore'
    export default {
        components: {Counter, Team},
        methods: {
            nl2br: function(str) {
                str = String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
                return str.replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + '<br/>' + '$2');
            }
        },
        data () {
            return {
                userState: user.state,
                biography: ''
            };
        },
        mounted (){
            this.$http.get('/api/user/me', {headers: {Authorization: 'JWT ' + user.getToken()}}).then((response) => {
                response.json().then((message) => {
                    user.setUser(message.data);
                    this.biography = message.data.biography;
                });
            }, (response) => {
                console.warn('Erreur Dashboard.vue /api/user/me');
            });
        }
    };
</script>

<style>
    @media screen and (min-width: 700px) {
        #dashboard {
            padding: 10px;
            padding-bottom: 5vh;
            max-width: 1200px;
            margin: 0 auto;
        }
    }
</style>
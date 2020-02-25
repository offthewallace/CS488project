<template>
    <div class="bg">
        <Header></Header>
        <div class="container align-items-center justify-content-center text-center color1">
            <div class="row">
                <div class="col-sm margin1">
                    <button class="bold styled" v-on:click="getBasic" ref="basic">Proportions</button>
                    <button class="styled" v-on:click="getActions" ref="actions">TOP-charts</button>
                </div>
            </div>
            <hr>
            <div class="container" v-if="basic">
                <div class="row">
                    <div class="col-sm">
                        <p class="bold"> GENDER PROPORTION</p>
                        <pie-chart class="chart" v-if="loaded" :data="chartData"/>
                    </div>
                    <div class="col-sm">
                        <p class="bold"> COUNTRY PROPORTION</p>
                        <pie-chart class="chart" v-if="loaded" :data="chartData1"/>
                        <div v-if="loaded1">test</div>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-sm">
                        <p class="bold"> HOBBY PROPORTION</p>
                        <bar-chart class="chart hobby-chart" v-if="loaded" :options="options" :data="chartData2"/>
                    </div>
                </div>
                <hr>
            </div>
            <div class="container" v-if="actions">
                <div class="row margin2">
                    <div class="col-sm text-center">
                        <p class="bold">MOST POPULAR USERS</p>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>NAME</th>
                                    <th>LIKES</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="(mostLikeableUser, index) in mostLikeableUsers">
                                    <td>{{index}}</td>
                                    <td>{{ mostLikeableUser.name}}</td>
                                    <td>{{ mostLikeableUser.likes}}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-sm text-center">
                        <p class="bold">MOST TALKATIVE USERS</p>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>NAME</th>
                                    <th>AMOUNT OF MESSAGES</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="(mostTalkativeUser, index) in mostTalkativeUsers">
                                    <td>{{index}}</td>
                                    <td>{{mostTalkativeUser.name}}</td>
                                    <td>{{ mostTalkativeUser.amountOfMessages}}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import {AXIOS} from '../resources/http.config'
    import PieChart from "../resources/PieChart.js";
    import LineChart from "../resources/LineChart.js";
    import Header from '../navigation/Header.vue'
    import BarChart from "../resources/BarChart.js";

    export default {
        components: {
            PieChart,
            LineChart,
            BarChart,
            Header
        },
        // app initial state
        data() {
            return {
                info: [],
                countries: [],
                hobbies: [],
                hobbiesAmount: [],
                countriesAmount: [],
                user: {},
                mostLikeableUsers: [],
                mostTalkativeUsers: [],
                id: 1,
                options: {
                    legend: {
                        display: false
                    },
                    scales:
                        {
                            yAxes:
                                [{

                                    stacked: true,
                                    ticks: {
                                        min: 0,
                                        stepSize: 1,
                                    }

                                }],
                            xAxes:[{
                                ticks: {
                                    autoSkip: false
                                }
                            }]
                        }
                },
                loaded: false,
                loaded1: false,
                loaded2: false,
                lineChartData: null,
                chartData: {
                    labels: ["FEMALE", "MALE"],
                    datasets: [
                        {
                            label: "Data One",
                            backgroundColor: ["#f93d7b", "#00D8FF"],
                            data: {}
                        }
                    ]
                },
                chartData1: {
                    labels: [],
                    datasets: [
                        {
                            label: "Data One",
                            backgroundColor: ["#DC143C", "#6495ED", "#8B008B", "#FF8C00", "#FFD700", "#FF69B4",
                                "#C71585", "#FF4500", "#87CEEB", "#008080", 'pink'],
                            data: []
                        }
                    ]
                },
                chartData2: {
                    labels: [],
                    datasets: [
                        {
                            backgroundColor: ["#DC143C", "#6495ED", "#8B008B", "#FF8C00", "#FFD700", "#FF69B4",
                                "#C71585", "#FF4500", "#87CEEB", "#008080", 'red', 'yellow'],
                            data: []
                        }
                    ],
                    options:{}

                },
                basic: true,
                actions:
                    false,
            }


        },
        created: function () {
            this.getMostLikeableUsers();
            this.getMostTalkativeUsers();
        }
        ,

        mounted() {
            this.fillLineData();
            this.getUser();
            BarChart.defaults.global.legend.display = false;
        }
        ,
        // methods that implement data logic.
        // note there's no DOM manipulation here at all.
        methods: {
            getBasic: function () {
                this.basic = true;
                this.actions = false;
                this.$refs.basic.setAttribute("style", "font-weight:bold; outline: none; border: none");
                this.$refs.actions.setAttribute("style", "font-weight:normal; outline: none; border: none");
            }
            ,
            getActions: function () {
                this.basic = false;
                this.actions = true;
                this.$refs.basic.setAttribute("style", "font-weight:normal; outline: none; border: none");
                this.$refs.actions.setAttribute("style", "font-weight:bold; outline: none; border: none");
            }
            ,

            getUser: function () {
                AXIOS.get('/stats/')
                    .then(response => {
                        this.user = response.data;

                        //chart data
                        this.chartData.datasets[0].data = [this.user[0], this.user[1]];
                        this.getCountryProportion();
                    })
            }
            ,
            getMostLikeableUsers: function () {
                AXIOS.get('/stats/likes')
                    .then(response => {
                        this.mostLikeableUsers = response.data;
                    })
            }
            ,
            getMostTalkativeUsers: function () {
                AXIOS.get('/stats/userByMessages')
                    .then(response => {
                        this.mostTalkativeUsers = response.data;
                    })
            }
            ,
            getCountryProportion: function () {
                AXIOS.get('/stats/userByCountry').then(response => {
                    // this.countries = response.data;
                    let countriesDict = response.data;
                    for (let key in countriesDict) {
                        let value = countriesDict[key];
                        this.countries.push(key);
                        this.countriesAmount.push(value);
                    }
                    this.chartData1.labels = this.countries;
                    this.chartData1.datasets[0].data = this.countriesAmount;
                    this.getHobbyProportion();

                });
            }
            ,
            getHobbyProportion: function () {
                AXIOS.get('/stats/userByHobby').then(response => {
                    let hobbies = response.data;
                    for (let i in hobbies) {
                        let hobby = hobbies[i];
                        this.hobbies.push(hobby.hobbyName);
                        this.hobbiesAmount.push(hobby.hobbyAmount);
                    }
                    this.chartData2.labels = this.hobbies;
                    this.chartData2.datasets[0].data = this.hobbiesAmount;
                    this.loaded = true;
                });
            }
            ,
            fillLineData() {
                this.lineChartData = {
                    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
                    datasets: [
                        {
                            backgroundColor: '#f87979',
                            data: [1, 2, 1, 4, 2, 4, 5, 1, 6, 8, 4, 3]
                        }
                    ]
                }
            }
            ,
            logOut: function () {
                localStorage.removeItem("token");
                this.$router.push("DatingApp");
            }
        }
    }
</script>

<style scoped>
    .color1 {
        background-color: #F4F4F4;
        margin-top: 68px;
    }

    .bold {
        font-weight: bold;
    }

    .styled {
        border: none;
        outline: none;
    }

    .chart {
        margin: auto;
        width: 300px;
    }

    .margin1 {
        margin-top: 5vh;
    }

    .margin2 {
        width: 100%;
        margin-top: 5vh;
    }
    @media only screen and (max-width: 350px)  {
        .chart {
        width: 250px}
    }

</style>

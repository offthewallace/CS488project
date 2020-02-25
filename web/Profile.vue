<template>
    <div class="bg" style="background-color: rgba(248,211,173,0.06)">
        <Header></Header>

        <hr>
        <hr>

        <div v-if="!loaded" class="container align-items-center justify-content-center base">
            <img src="../../assets/load3.gif"/>
        </div>
        <div v-if="loaded" class="container align-items-center justify-content-center fixed">
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-10 styled border">
                    <div class="row margin">
                        <div class="col-sm">
                            <div id="demo" class="carousel slide" data-ride="carousel">
                                <!-- Indicators -->
                                <ol class="carousel-indicators">
                                    <li data-target="#demo" v-for="(img, index) in user.image" data-slide-to="$index"></li>
                                </ol>
                                <!-- The slideshow -->
                                <div class="carousel-inner">
                                    <div class="carousel-item active">
                                        <img class="profileImage" v-bind:src=" firstImg" width="100">
                                    </div>
                                    <div class="carousel-item" v-for="img in otherImg">
                                        <img class="profileImage" v-bind:src="'data:image/jpeg;base64,'+ img" width="100">
                                    </div>
                                </div>
                                <!-- Left and right controls -->
                                <a class="carousel-control-prev" href="#demo" data-slide="prev">
                                    <span class="carousel-control-prev-icon"></span>
                                </a>
                                <a class="carousel-control-next" href="#demo" data-slide="next">
                                    <span class="carousel-control-next-icon"></span>
                                </a>
                            </div>
                            <div>
                                <input class="no-border d-none" type="file" @change="onFileChanged" id="file"/>
                                <label class="btn" for="file">CHANGE PHOTO</label>
                                <p v-if="errorMode" class="error">{{photoError}}</p>
                                <p v-if="fileChosen">{{file.name}}</p>
                                <button v-if="fileChosen" @click="onUpload" type="button" class="btn">UPLOAD</button>
                            </div>
                        </div>
                        <div class="col-sm text-left" v-if="editMode">
                            <table class="box">
                                <tr>
                                    <td></td>
                                    <td>
                                        <a><font-awesome-icon v-on:click="changeMode" icon="chevron-right" class="fa-2x aStyle"/></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="capitalize">NAME:</td>
                                    <td>
                                        <input type="text" maxlength="20" v-model="user.name"/>
                                        <span v-if="errorMode" class="text-danger small-text">{{this.errorName}}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="capitalize">SURNAME:</td>
                                    <td>
                                        <input type="text" maxlength="20" v-model="user.surname"/>
                                        <span v-if="errorMode" class="text-danger small-text">{{this.errorSurname}}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="capitalize">EMAIL:</td>
                                    <td>
                                        <input type="text" maxlength="30" v-model="user.username"/>
                                        <span v-if="errorMode" class="text-danger small-text">{{this.errorEmail}}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="capitalize">COUNTRY:</td>
                                    <td>
                                        <select v-model="user.country" class="selectOption" v-on:click="checkCity">
                                            <option class="disabled" value="" disabled selected>Select country</option>
                                            <option class="selectOption" v-for="(value, key) in Countries" :key="key">{{ key }} </option>
                                        </select>
                                        <span v-if="errorMode" class="text-danger small-text">{{this.errorCountry}}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="capitalize">CITY:</td>
                                    <td>
                                        <select v-model="user.city" class="selectOption" v-on:click="checkCity">
                                            <option class="disabled" value="" disabled selected>Select city</option>
                                            <option class="selectOption" v-for="cities in getCities()" :key="cities">{{ cities }} </option>
                                        </select>
                                        <span v-if="errorMode" class="text-danger small-text">{{this.errorCity}}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <label class="capitalize">HOBBY:</label>
                                        <v-select class="selectOption" v-model="hobbies" multiple :options="allHobbies"/>
                                        <span v-if="errorMode" class="text-danger small-text">{{this.hobbyError}}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="decorated">BIO</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <textarea v-model="user.bio" id="bio"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center">
                                        <button class="btn" v-on:click="saveInfo">SAVE</button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-sm text-left margin1" v-else>
                            <div class="row">
                                <span class="span1">{{user.name}} {{user.surname}}, {{user.age}}</span>
                                <div class="w-100"></div>
                                <span class="bold"></span><span>{{user.city}}, {{user.country}}</span>
                            </div>
                            <div class="row rowFix1">
                                <span class="bold">Age: </span><span>{{user.birth}}</span>
                            </div>
                            <div class="row rowFix1">
                                <span class="bold">hobby</span>
                                <span>{{user.Hobby}}</span>
                            </div>
                            <div class="row rowFix1">
                                <span class="bold">BIO</span>
                                <div class="w-100"></div>
                                <span>{{user.bio}}</span>
                            </div>
                            
                            
                            <div class="row rowFix2" >
                                
                                 
                            </div>
                        </div>
                        <div class="col-sm-1 rowFix2">
                            <a v-if="!editMode">
                                <font-awesome-icon v-on:click = "editHTML" icon="user-edit" class="fa-2x"/>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-sm-1"></div>
            </div>
        </div>
    </div>
</template>

<script>
    import {AXIOS} from '../resources/http.config'
    import Countries from '../resources/countries.json'
    import Hobbies from '../resources/hobbies.json'
    import Header from '../navigation/Header.vue'

    export default {
        name: "Profile",
        components: {Header},
        comments: {
            Header
        },
        data() {
            return {
                errorEmail: null,
                errorName: null,
                errorCity: null,
                errorCountry: null,
                errorSurname: null,
                hobbyError: null,
                loaded:true,
                editMode: false,
                fileChosen: false,
                changePhotoMode: false,
                errorMode: false,
                photoError: null,
                error: {},
                user: {},
                firstImg: {},
                otherImg: [],
                username: "",
                file: "",
                matchingPercentage: {},
                userHobbies: [],
                hobbies: [],
                allHobbies: [],
                Countries,
                image: null,
            }
        },
        mounted: function() {
            if (localStorage.getItem('token')) {
                //AXIOS.defaults.headers.common['Authorization'] = localStorage.getItem('token');
                //this.user=localStorage.getItem('user')
                
                this.getUser();
                //console.log(this.user);
            }
            this.collectHobbies()
        },
        methods: {
            collectHobbies: function() {
                for(let el in Hobbies['hobbies']){
                    this.allHobbies.push(Hobbies['hobbies'][el])
                }
            },
            editHTML: function () {
                this.editMode = true;
            },
            changeMode: function () {
                this.editMode = false;
                this.setEditUser();
            },
            saveHobbies: function() {
                this.user.Hobby=this.hobbies;
                console.log(this.hobbies);
                console.log("Test SaveHobby");
                //console.log(this.user);
                console.log("Test adding Edituser.hobby");
                /*
                let dto = {
                    'userId': this.user.id,
                    'hobby': ""
                };
                for(let el in this.userHobbies){
                    if (!this.hobbies.includes(this.userHobbies[el])) {
                        dto['hobby'] = this.userHobbies[el];
                        
                        AXIOS.delete('/hobby', {'data': dto})
                            .catch(error => {
                                this.hobbyError = error.response.data[0].defaultMessage;
                                this.errorMode = true
                            })
                    }
                }
                for(let el in this.hobbies) {
                    if(!this.userHobbies.includes(this.hobbies[el])) {
                        dto['hobby'] = this.hobbies[el];
                        
                        AXIOS.post('/hobby', dto)
                            .catch(error => {
                                this.hobpostbyError = error.response.data[0].defaultMessage;
                                this.errorMode = true
                            })

                    }
                }
            */
            },
            saveInfo: function () {
                this.saveHobbies();
                this.updateErrors();
                this.checkCity();
                if (this.user.city !== "Select city") {
                    this.user.previousKey=this.user.username;
                    let sendData=JSON.stringify(this.user);
                    //localStorage.setItem('user',this.user);
                    console.log("test on what data to send ");
                    console.log(sendData);
                    AXIOS.put('/users', sendData)
                        .then(this.setEditUser2).then(console.log(this.user))
                            /*
                        .catch(error => {
                            this.error = error.response.data;
                            for (let e in this.error) {
                                if (this.error[e].field === "email") {
                                    this.errorEmail = this.error[e].defaultMessage;
                                }
                                else if (this.error[e].field === "name") {
                                    this.errorName = this.error[e].defaultMessage;
                                }
                                else if (this.error[e].field === "surname") {
                                    this.errorSurname = this.error[e].defaultMessage;
                                }
                                else if (this.error[e].field === "city") {
                                    this.errorCity = this.error[e].defaultMessage;
                                }
                                else if (this.error[e].field === "country") {
                                    this.errorCountry = this.error[e].defaultMessage;user
                            this.errorMode = true;
                        })*/;
                }
            },
            getUser: function () {

                        this.user=JSON.parse(localStorage.getItem('user'));
                        //localStorage.removeItem('user');
                        //this.user = response.data;
                        this.setEditUser();
                        //console.log(typeof this.user);
                        //console.log("test on getUser to get the this.user.info")
                        //console.log(this.user);
                        //console.log(this.user["city"]);
                        this.firstImg = this.user['image'];
                        /* I am lazy to support muli image 
                        this.otherImg = [];
                        for (let i=1; i<this.user.image.length; i++){
                            this.otherImg.push(this.user.image[i].name);
                        }*/

                        this.username = this.user.name;
                        this.hobbies = [];
                        for (let el in this.user.hobby) {
                           this.hobbies.push(this.user.hobby[el])
                        }
                        this.userHobbies = this.hobbies;
                        this.setLoaded();
                        this.editMode = false;
                        /*
                        AXIOS.get('stats/matchPercentage/' + this.user.id )
                            .then(response => {
                                this.matchingPercentage = response.data;
                                this.setLoaded();
                                this.editMode = false;
                            });*/
            },
            updateUser: function(){
                console.log("test on Update User");
                console.log(this.user);
                console.log("test on this.user");
                console.log(this.user);


                this.user.name=this.user.name;
                //this.user.surname=this.edituser.surname;
                this.user.city=this.user.city;
                this.user.country=this.user.country;
                this.user.bio=this.user.bio;
                this.user.hobbies=this.user.Hobby;
                localStorage.setItem('user',this.user);
                
            },
            setEditUser: function(){
                //localStorage.removeItem('user');
                this.hobbies = this.userHobbies;
                for (let i in this.user) {
                    this.user[i] = this.user[i]
                }
            },
            setEditUser2:function(){
                localStorage.removeItem('user');
                for (let i in this.user) {
                    this.user[i] = this.user[i]
                }
                this.firstImg = this.user['image'];
                        /* I am lazy to support muli image 
                        this.otherImg = [];
                        for (let i=1; i<this.user.image.length; i++){
                            this.otherImg.push(this.user.image[i].name);
                        }*/

                this.username = this.user.name;
                this.hobbies = [];
                for (let el in this.user.hobby) {
                    this.hobbies.push(this.user.hobby[el])
                }
                this.userHobbies = this.hobbies;
                localStorage.setItem('user',this.user);
                this.setLoaded();
                this.editMode = false;
                localStorage.setItem('user',user)

            },
            setLoaded: function() {
                setTimeout(() => this.loaded= true, 500);
            },
            getCities: function() {
                let country = this.user.country;
                return Countries[country]
            },
            checkCity: function() {
                let country = this.user.country;
                let city = this.user.city;
                if (!Countries[country].includes(city) || city === "Select city" || country === "Select country") {
                    console.log(this.user.city);
                    this.user.city = "Select city";
                }
                console.log("check city");
            },
            onFileChanged (event) {
                console.log(event.target.files);
                this.file = event.target.files[0];
                this.fileChosen= true;
                

            },
            
            onUpload() {

          
                //console.log(typeof this.file);
                //let imgData = JSON.stringify(this.file);
                //console.log(imgData);

                //let send={}
                //fd.append('file', this.file);
                //send["image"]=fd;
                //send['keyword']=this.user.username;
                let config = {header : {'Content-Type' : ' undefined'},
                transformRequest: function (data) {
	                let formData = new FormData();
	                //need to convert our json object to a string version of json otherwise
	                // the browser will do a 'toString()' on the object which will result
	                // in the value '[Object object]' on the server.
	                formData.append("myJsoNData", JSON.stringify(data.myExtraData));
	                formData.append("thumbnail", data.thumbnail)
	                return formData;
	            },
                data: {myExtraData: this.user.username, thumbnail: this.file}
                };

                //console.log(imgData);
                AXIOS.post('/users/image', config)
                    .then(this.getUser)
                    .catch(error => {
                        this.photoError = error.response.data[0].defaultMessage;
                        this.errorMode = true;
                });

                this.fileChosen = false;
            },
            updateErrors: function () {
                this.errorEmail = null;
                this.errorName = null;
                this.errorCity = null;
                this.errorCountry = null;
                this.errorSurname = null;
                this.photoError = null;
                this.hobbyError = null
            }
        }
    }
</script>

<style scoped>
    .base{
        margin-top: 68px!important;
    }
    .fixed {
        margin-top: 68px;
    }

    .styled {
        background-color: #F4F4F4;
        border-radius: 5px;
        border: #3b2b49
    }
    .margin {
        margin-top: 5vh!important;
        margin-bottom: 5vh!important;
    }

    .margin1 {
        margin: 0 20px;
    }

    .btn {
        background-color: #751b26;
        color: white;
        border-radius: 5px;
        margin-top: 2vh
    }
    .error {
        color: red;
    }

    .fa-2x {
        color: #751b26;
    }

    .aStyle {
        float: right;
    }
    .iconStyle {
        margin-left: 1ch
    }
    .hobby {
        background-color: #fbeeff;
        border-radius: 5px;
    }

    .bold {
        font-weight: bold
    }

    .rowFix1 {
        margin-top: 3vh
    }

    .rowFix2 {
        margin-top: 2vh;
        margin-right: 3vh;
    }
    .label {
        font-weight: bold;
        color: #bd1651;
        background-color: transparent;
    }

    .span1 {
        font-weight: bold;
        font-size: 2ch
    }

    .span2 {
        color: #bd1651;
        font-size: 23px
    }

    .selectOption{
        margin-bottom: 10px;
    }
</style>

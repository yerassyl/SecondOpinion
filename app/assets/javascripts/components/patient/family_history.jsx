
var FamilyHistoryBox = React.createClass({

    getInitialState: function() {
        return {
            familyHistories: [],
            form: [],
            formClass: 'hide',
            trashClass: 'hide'
        }
    },
    componentDidMount: function(){
        $.ajax({
            url: this.props.url_get+"?id="+this.props.patient_id,
            dataType: 'json',
            success: function(data){
                this.setState({familyHistories: data.familyHistories});
                this.setState({form: data.form});
            }.bind(this),
            error: function(xhr, status, err){
                //console.error(this.props.url_get, status, err.toString());
            }.bind(this)
        });
    },
    handleFamilyHistorySubmit: function(familyHistory){
        console.log(familyHistory);
        // optimistic add
        var familyHistories = this.state.familyHistories;
        familyHistory.id = Date.now();
        var newFamilyHistories = familyHistories.concat([familyHistory]);
        this.setState({familyHistories: newFamilyHistories});

        // form data to be submitted
        var formData = {
            csrf_token: familyHistory.csrf_token,
            csrf_param: familyHistory.csrf_param,
            'family_history[skype]': familyHistory.skype,
            'family_history[email]': familyHistory.email,
            'family_history[alive]': familyHistory.alive,
            'family_history[age]': familyHistory.age,
            'family_history[relationship]': familyHistory.relationship,
            'family_history[other_information]': familyHistory.other_information,
            'family_history[patient_id]': this.props.patient_id
        };

        $.ajax({
            url: this.props.url_post,
            dataType: 'json',
            method: 'POST',
            data: formData,
            success: function(data){
                this.setState({familyHistories: data.familyHistories });
            }.bind(this),
            error: function(xhr, status, err){
                this.setState({familyHistories: familyHistories });
                console.error(this.props.url_post, status, err.toString());
            }.bind(this)
        });
    },
    handleFhDelete: function(fh){
        // optimistic delete
        var familyHistories = this.state.familyHistories;
        var newFamilyHistories = familyHistories.filter(function(a){
            return a.id != fh.id;
        });
        this.setState({familyHistories: newFamilyHistories});
        $.ajax({
            url: this.props.url_delete,
            dataType: 'json',
            method: 'DELETE',
            data: {fh_id: fh.id},
            success: function(data){
                //this.setState({allergiesList: data.allergiesList});
            }.bind(this),
            error: function(xhr,status,err){
                this.setState({familyHistories: familyHistories});
                //console.error(this.props.url_delete, status, err.toString());
            }.bind(this)
        });
    },
    handleFormToggle: function(toggle){
        var formClass = (toggle) ? "show" : "hide";
        this.setState({formClass: formClass});
    },
    handleTrashToggle: function(toggle){
        var formClass = (toggle) ? "show" : "hide";
        this.setState({trashClass: formClass});
    },
    render: function() {
        return (
            <div className="familyHistory">
                <FamilyHistoryList familyHistories={this.state.familyHistories} trashClass={this.state.trashClass}
                    onFhDelete={this.handleFhDelete}/>
                <FamilyHistoryMenu onFormClassChange={this.handleFormToggle} onToggleTrash={this.handleTrashToggle} />
                <FamiliyHistoryForm form={this.state.form} onFamilyHistorySubmit={this.handleFamilyHistorySubmit} formClass={this.state.formClass}/>
            </div>
        )
    }
});

var FamilyHistoryList = React.createClass({
    onFhDelete: function(fh) {
       this.props.onFhDelete(fh);
    },
    render: function(){
        var familyHistories = this.props.familyHistories.map(function(familyHistory){
           return  <FamilyHistory familyHistory={familyHistory} key={familyHistory.id}
                                  onFhDelete={this.onFhDelete} trashClass={this.props.trashClass} />
        }, this);
        return (
            <ul>
                {familyHistories}
            </ul>
        )
    }
});

var FamilyHistory = React.createClass({
    deleteFh: function(event){
        event.preventDefault();
        var fh = this.props.familyHistory;
        this.props.onFhDelete( fh );
    },
   render: function(){
       return (
           <li className="familyHistory-obj">
               <span> {this.props.familyHistory.skype} | {this.props.familyHistory.email} </span><br/>
               <span> {this.props.familyHistory.age} years old </span>
               <span> | {this.props.familyHistory.relationship} </span>
               <span> {this.props.familyHistory.other_information}</span>
               <span className="fr">
                   <span className={this.props.trashClass}>
                       <a href="#" onClick={this.deleteFh} className="fa fa-trash" > </a>
                   </span>
               </span>
           </li>
       )
   }
});
var FamilyHistoryMenu = React.createClass({
    getInitialState: function(){
        return {
            addMenu: true,
            deleteMenu: true
        }
    },
    // show/hide add Disease form
    toggleAdd: function(){
        this.setState({addMenu: !this.state.addMenu});
        this.props.onFormClassChange(this.state.addMenu);
    },
    toggleTrash: function(){
        this.setState({deleteMenu: !this.state.deleteMenu});
        this.props.onToggleTrash(this.state.deleteMenu);
    },
   render: function(){
       return (
           <div className="row">
               <div className="small-12 large-12 columns">
                   <h4 className="sub-menu">
                       <i className="fa fa-plus-square" onClick={this.toggleAdd}></i>
                       <i className="fa fa-trash" onClick={this.toggleTrash}></i>
                   </h4>
               </div>
           </div>
       )
   }
});

var FamiliyHistoryForm = React.createClass({
    getInitialState: function(){
        return {
            skype: '',
            email: '',
            alive: true,
            age: 0,
            relationship: '',
            otherInformation: ''
        }
    },
    addFamilyHistory: function(event){
        event.preventDefault();
        // collect all form inputs + csrf
        var csrf_param = this.props.form.csrf_param;
        var csrf_token = this.props.form.csrf_token;

        var skype = this.state.skype.trim();
        var email = this.state.email.trim();
        var alive = this.state.alive;
        var age = this.state.age;
        var relationship = this.state.relationship;
        var otherInformation = this.state.otherInformation.trim();

        if (!skype || !email) {
            if (!skype) {
                this.setState({skypeClass: 'error-input-field'});
                this.setState({skypePlaceholder: 'this field cant be blank'});
            }
            if (!email) {
                this.setState({emailClass: 'error-input-field'});
                this.setState({emailPlaceholder: 'this field cant be blank'});
            }
            return;
        }

        this.props.onFamilyHistorySubmit({
            csrf_param: csrf_param,
            csrf_token: csrf_token,
            skype: skype,
            email: email,
            alive: alive,
            age: age,
            relationship: relationship,
            otherInformation: otherInformation
        });


    },
    // functions below handle changes of state in form inputs
    skypeChanged: function(event){
        this.setState({skype: event.target.value});
    },
    emailChanged: function(event){
        this.setState({email: event.target.value});
    },
    aliveChanged: function(){
        this.setState({alive: !this.state.alive});
    },
    relationshipChanged: function(event){
        this.setState({relationship: event.target.value});
    },
    ageChanged: function(event){
        this.setState({age: event.target.value});
    },
    otherInfoChanged: function(event){
        this.setState({otherInformation: event.target.value});
    },
    render: function(){
        return (
            <form onSubmit={this.addFamilyHistory} method="post" acceptCharset="utf-8" className={this.props.formClass} >
                <input name="utf8" type="hidden" value="✓" />
                <input type="hidden" name={ this.props.form.csrf_param} value={ this.props.form.csrf_token } />

                <div className="row">
                    <div className="large-12 columns">

                        <div className="row collapse">
                            <div className="small-4 large-4 columns">
                                <span className="prefix">Skype</span>
                            </div>
                            <div className="small-8 large-8 columns">
                                <input type="text" value={this.state.skype} onChange={this.skypeChanged}
                                       className={this.state.skypeClass} placeholder={this.state.skypePlaceholder}/>
                            </div>
                        </div>

                    </div>
                </div>

                <div className="row">
                    <div className="large-12 columns">

                        <div className="row collapse">
                            <div className="small-4 large-4 columns">
                                <span className="prefix">Email</span>
                            </div>
                            <div className="small-8 large-8 columns">
                                <input type="text" value={this.state.email} onChange={this.emailChanged}
                                    className={this.state.emailClass} placeholder={this.state.emailPlaceholder}/>
                            </div>
                        </div>

                    </div>
                </div>

                <div className="row">
                    <div className="large-12 columns">
                        <select name="alive" defaultValue={this.state.alive} onChange={this.aliveChanged}>
                            <option value="alive">Alive</option>
                            <option value="deceased">Deceased</option>
                        </select>
                    </div>
                </div>

                <div className="row">
                    <div className="large-12 columns">
                        <select name="relationship" defaultValue={this.state.relationship} onChange={this.relationshipChanged}>
                            <option value="-">-</option>
                            <option value="father">Father</option>
                            <option value="mother">Mother</option>
                            <option value="brother">Brother</option>
                            <option value="sister">Sister</option>
                        </select>
                    </div>
                </div>

                <div className="row">
                    <div className="large-12 columns">

                        <div className="row collapse">
                            <div className="small-4 large-4 columns">
                                <span className="prefix">Age</span>
                            </div>
                            <div className="small-8 large-8 columns">
                                <input type="number" value={this.state.age} onChange={this.ageChanged} />
                            </div>
                        </div>

                    </div>
                </div>

                <div className="row">
                    <div className="large-12 columns">

                        <div className="row collapse">
                            <div className="small-7 large-5 columns">
                                <span className="prefix">Other Information</span>
                            </div>
                            <div className="small-5 large-7 columns">
                                <input type="text" value={this.state.otherInformation} onChange={this.otherInfoChanged} />
                            </div>
                        </div>

                    </div>
                </div>

                <div className="row">
                    <div className="small-12 large-12 columns">
                        <input type="submit" className="button tiny add" value="Add"/>
                    </div>
                </div>

            </form>
        )
    }

});


// dry input field
// to be done later
var inputField = React.createClass({
    getDefaultProps: function(){
      return {
          label: '',
          fieldType: '',
          state: {}
      }
    },
   render: function(){
       return (
           <div className="row">
               <div className="large-12 columns">

                   <div className="row collapse">
                       <div className="small-4 large-4 columns">
                           <span className="prefix">{this.props.label}</span>
                       </div>
                       <div className="small-8 large-8 columns">
                           <input type="number" value={this.state.age} onChange={this.ageChanged} />
                       </div>
                   </div>

               </div>
           </div>
       )
   }
});
var AllergyBox = React.createClass({
    getInitialState: function(){
      return {
          allergiesList: [],
          form: [],
          formClass: "hide",
          trashClass: "hide"
      }
    },
    getDefaultPros: function(){
        return {
            url_get: "",
            url_post: "",
            url_delete: "",
            patient_id: 0
        }
    },
    componentDidMount: function(){
      $.ajax({
          url: this.props.url_get+"?id="+this.props.patient_id,
          dataType: 'json',
          success: function(data){
            this.setState({allergiesList: data.allergiesList});
            this.setState({form: data.form});
          }.bind(this),
          error: function(xhr, status, err){
              console.error(this.props.url, status, err.toString());
          }.bind(this)
      });
    },
    handleAllergySubmit: function(allergy) {
        // optimistic update
        var allergies = this.state.allergiesList;
        var tempAllergy = {
            name: allergy.name,
            id: Date.now()
        };
        var newAllergies = allergies.concat([tempAllergy]);
        this.setState({allergiesList: newAllergies});
        // declare formData to be submitted
        var formData = {
                csrf_token: allergy.csrf_token,
                csrf_param: allergy.csrf_param,
                'allergy[name]': allergy.name,
                'allergy[patient_id]': this.props.patient_id
            };
        $.ajax({
            url: this.props.url_post,
            dataType: 'json',
            method: 'POST',
            data: formData,
            success: function(data){
                this.setState({allergiesList: data.allergiesList });
            }.bind(this),
            error: function(xhr, status, err){
                this.setState({allergiesList: allergies });
                console.error(this.props.url_post, status, err.toString());
            }.bind(this)
        });
    },
    handleAllergyDelete: function(allergy){
        // optimistically delete
        var allergies = this.state.allergiesList;
        var newAllergies = allergies.filter(function(a){
            return a.id != allergy.id;
        });
        this.setState({allergiesList: newAllergies});
        // handle allergy delete here
        var allergy_id = allergy.id;
        $.ajax({
            url: this.props.url_delete,
            dataType: 'json',
            method: 'DELETE',
            data: {allergy_id: allergy_id},
            success: function(data){
                //this.setState({allergiesList: data.allergiesList});
            }.bind(this),
            error: function(xhr,status,err){
                this.setState({allergiesList: allergies});
                console.error(this.props.url_delete, status, err.toString());
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
    render: function(){
        return(
            <div className="allergies">
                <AllergiesList allergies={this.state.allergiesList}
                               onHandleDelete={this.handleAllergyDelete}
                                trashClass={this.state.trashClass} />

                <AllergyMenu onFormClassChange={this.handleFormToggle}
                            onTrashToggle={this.handleTrashToggle} />

                <AllergyForm url={this.props.url_post} form={this.state.form}
                             onAllergySubmit={this.handleAllergySubmit}
                             obj={this.props.obj}
                             formClass={this.state.formClass}/>
            </div>
        )
    }
});

var AllergiesList = React.createClass({
    getDefaultProps: function(){
      return {allergies: []}
    },
    handleAllergyDelete: function(allergy){
      // pass allergy id up to AllergyBox
      this.props.onHandleDelete({id: allergy.id});
    },
    render:function(){
        //var that = this;
        var allergies = this.props.allergies.map(function(allergy){
            return(
            <Allergy onAllergyDelete={this.handleAllergyDelete}
                     name={allergy.name} key={allergy.id} id={allergy.id}
                    trashClass={this.props.trashClass} />
            )
        },this);
        return(
            <ul>
                {allergies}
            </ul>
        )
    }
});
//
var Allergy = React.createClass({

    deleteAllergy: function(e){
        e.preventDefault();
        var allergy_id = this.props.id;
        // pass allergy id up to AllergyList
        this.props.onAllergyDelete({
           id: allergy_id
        });
    },
    render: function(){
        return(
            <li className="allergy-obj">
                {this.props.name}
                <span className="fr">
                    <span className={this.props.trashClass}>
                        <a href="#" onClick={this.deleteAllergy} className="fa fa-trash fr"> </a>
                    </span>
                </span>
            </li>


        )
    }
});

var AllergyMenu = React.createClass({
    getInitialState: function(){
        return {
            addMenu: true,
            deleteMenu: true
        }
    },
    // show/hide add Disease form
    toggleAddAllergy: function(){
        this.setState({addMenu: !this.state.addMenu});
        this.props.onFormClassChange(this.state.addMenu);

    },
    toggleTrash: function(){
        this.setState({deleteMenu: !this.state.deleteMenu});
        this.props.onTrashToggle(this.state.deleteMenu);
    },
    render: function(){
        return (
            <div className="row">
                <div className="small-12 large-12 columns">
                    <h4 className="sub-menu">
                        <i className="fa fa-plus-square" onClick={this.toggleAddAllergy}></i>
                        <i className="fa fa-trash" onClick={this.toggleTrash}></i>
                    </h4>
                </div>
            </div>
        )
    }
});

var AllergyForm = React.createClass({

    getInitialState: function(){
      return {inputText: "" }
    },
    handleInputChange: function(e){
        this.setState( {inputText: e.target.value});
    },
    addAllergy: function(e){
        e.preventDefault();
        var csrf_param = this.props.form.csrf_param;
        var csrf_token = this.props.form.csrf_token;
        var input = this.state.inputText.trim();
        if (!input){
            return;
        }
        // form params
        this.props.onAllergySubmit({
            csrf_param: csrf_param,
            csrf_token: csrf_token,
            name: input
        });

        this.setState({inputText: ""});
    },

    render:function(){
        return(
            <form className={this.props.formClass} onSubmit={this.addAllergy} method="post" action={this.props.url} acceptCharset="UTF-8">
             <input name="utf8" type="hidden" value="✓" />
             <input type="hidden" name={ this.props.form.csrf_param } value={ this.props.form.csrf_token } />
            <div className="row">
                <div className="large-12 columns">
                    <div className="row collapse">

                            <div className="small-10 columns">
                                <input type="text" name='allergy[name]' value={this.state.inputText} onChange={this.handleInputChange} />
                            </div>

                            <div className="small-2 columns">
                                <input type="submit" className="button postfix add" value="add"/>
                            </div>

                    </div>
                </div>
            </div>
            </form>
        )
    }
});


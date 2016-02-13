// allergies = allergies | diseases

var AllergyBox = React.createClass({

    getInitialState: function(){
      return {
          allergiesList: [],
          form: []
      }
    },
    getDefaultPros: function(){
        return {
            url_get: "",
            url_post: "",
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
                console.log(data);
                //this.setState({allergiesList: data });
            }.bind(this),
            error: function(xhr, status, err){
                this.setState({allergiesList: allergies });
                console.error(this.props.url_post, status, err.toString());
            }.bind(this)
        });
    },
    render: function(){
        return(
            <div className="allergies">
                <AllergiesList allergies={this.state.allergiesList} />
                <AllergyForm url={this.props.url_post} form={this.state.form}
                             onAllergySubmit={this.handleAllergySubmit} obj={this.props.obj}/>
            </div>
        )
    }
});

var AllergiesList = React.createClass({
    getDefaultProps: function(){
      return {allergies: []}
    },
    render:function(){
        var allergies = this.props.allergies.map(function(allergy){
            return(
                <Allergy name={allergy.name} key={allergy.id} />
            )
        });
        return(
            <ul>
                {allergies}
            </ul>
        )
    }
});

var Allergy = React.createClass({
    getDefaultProps: function(){
        return {
            id: 0,
            name: ""
        }
    },
    deleteAllergy: function(e){
        e.preventDefault();

    },
    render: function(){
        return(
            <li className="allergy-obj">{this.props.name} <a href="#" onClick={this.deleteAllergy} className="fa fa-trash"> </a> </li>
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
            <form className="addAllergy" onSubmit={this.addAllergy} method="post" action={this.props.url} acceptCharset="UTF-8">
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


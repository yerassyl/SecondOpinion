// chronics = allergies | diseases

var ChronicBox = React.createClass({

    getInitialState: function(){
      return {
          chronicsList: [],
          form: []
      }
    },
    getDefaultPros: function(){
        return {
            url_get: "",
            url_post: ""
        }
    },
    componentDidMount: function(){
      $.ajax({
          url: this.props.url_get,
          dataType: 'json',
          success: function(data){
            this.setState({chronicsList: data.chronicsList});
            this.setState({form: data.form});
          }.bind(this),
          error: function(xhr, status, err){
              console.error(this.props.url, status, err.toString());
          }.bind(this)
      });
    },
    handleChronicSubmit: function(chronic) {
        // optimistic update
        var chronics = this.state.chronicsList;
        var tempChronic = {
            name: chronic.name,
            id: Date.now()
        };
        var newChronics = chronics.concat([tempChronic]);
        // declare formData to be submitted
        var formData = {
            csrf_token: chronic.csrf_token,
            csrf_param: chronic.csrf_param,
            'allergy[name]': chronic.name
        }
        this.setState({chronicsList: newChronics});
        $.ajax({
            url: this.props.url_post,
            dataType: 'json',
            method: 'POST',
            data: formData,
            success: function(data){
                console.log(data);
                //this.setState({chronicsList: data });
            }.bind(this),
            error: function(xhr, status, err){
                this.setState({chronicsList: chronics });
                console.error(this.props.url_post, status, err.toString());
            }.bind(this)
        });
    },
    render: function(){
        return(
            <div className="chronics">
                <ChronicsList chronics={this.state.chronicsList} />
                <ChronicForm url={this.props.url_post} form={this.state.form}
                             onChronicSubmit={this.handleChronicSubmit} obj={this.props.obj}/>
            </div>
        )
    }
});

var ChronicsList = React.createClass({
    getDefaultProps: function(){
      return {chronics: []}
    },
    render:function(){
        var chronics = this.props.chronics.map(function(chronic){
            return(
                <Chronic name={chronic.name} key={chronic.id} />
            )
        });
        return(
            <ul>
                {chronics}
            </ul>
        )
    }
});

var Chronic = React.createClass({

    render: function(){
        return(
            <li>{this.props.name}</li>
        )
    }
});


var ChronicForm = React.createClass({

    getInitialState: function(){
      return {inputText: "" }
    },
    handleInputChange: function(e){
        this.setState( {inputText: e.target.value});
    },
    addChronic: function(e){
        e.preventDefault();
        var csrf_param = this.props.form.csrf_param;
        var csrf_token = this.props.form.csrf_token;
        var input = this.state.inputText.trim();
        if (!input){
            return;
        }
        // form params

        var object = this.props.obj+"[name]";
        this.props.onChronicSubmit({
            csrf_param: csrf_param,
            csrf_token: csrf_token,
            name: input
        });

        this.setState({inputText: ""});
    },

    render:function(){
        var name = this.props.obj+"[name]";
        return(
            <form className="addChronic" onSubmit={this.addChronic} method="post" action={this.props.url} acceptCharset="UTF-8">
             <input name="utf8" type="hidden" value="✓" />
             <input type="hidden" name={ this.props.form.csrf_param } value={ this.props.form.csrf_token } />
            <div className="row">
                <div className="large-12 columns">
                    <div className="row collapse">

                            <div className="small-10 columns">
                                <input type="text" name={name} value={this.state.inputText} onChange={this.handleInputChange} />
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




//$(document).ready(ready);

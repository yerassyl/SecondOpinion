
var ClientCallBackForm = React.createClass({
    render:function(){
        return(<form>
                <div className="form-field">
                    <input type="text" placeholder="Name" />
                </div>

                <div className="form-field">
                    <input type="number" placeholder="Phone" />
                </div>

                <div className="form-field">
                    <input type="text" placeholder="Name" />
                </div>

                <div className="form-field">
                    <input type="email" placeholder="Email" />
                </div>

                <div className="form-field">
                    <textarea name="message" placeholder="Message" />
                </div>

            </form>
        );
    }
});

var CountrySelect = React.createClass({
    render:function(){
        return(
            hi
        );
    }
});



var ready = function () {
    ReactDOM.render(
        <ClientCallBackForm />,
        document.getElementById('client-callback-form')
    );
};

//$(document).ready(ready);

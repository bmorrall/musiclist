import ApplicationController from './application_controller'

/* This is the custom StimulusReflex controller for AlbumStatusReflex.
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends ApplicationController {
  /* Reflex specific lifecycle methods.
   * Use methods similar to this example to handle lifecycle concerns for a specific Reflex method.
   * Using the lifecycle is optional, so feel free to delete these stubs if you don't need them.
   *
   * Example:
   *
   *   <a href="#" data-reflex="AlbumStatusReflex#example">Example</a>
   *
   * Arguments:
   *
   *   element - the element that triggered the reflex
   *             may be different than the Stimulus controller's this.element
   *
   *   reflex - the name of the reflex e.g. "AlbumStatusReflex#example"
   *
   *   error - error message from the server
   */

  // beforeUpdate(element, reflex) {
  //  element.innerText = 'Updating...'
  // }

  // updateSuccess(element, reflex) {
  //   element.innerText = 'Updated Successfully.'
  // }

  updateError(element, reflex, error) {
    console.error('updateError', reflex, error);
  //   element.innerText = 'Update Failed!'
  }

  ///////////////////////////////
  // Album Played Status
  ///////////////////////////////

  markPlayed(event) {
    event.preventDefault();

    this.stimulate("PlayedAlbumReflex#create", event.target)
  }

  removePlayed(event) {
    event.preventDefault();

    const ok = confirm("Are you sure?")
    if (!ok) {
      return false;
    }

    this.stimulate("PlayedAlbumReflex#destroy", event.target)
  }

  ///////////////////////////////
  // Album Purchased Status
  ///////////////////////////////

  markPurchased(event) {
    event.preventDefault();

    this.stimulate("PurchasedAlbumReflex#create", event.target)
  }

  removePurchased(event) {
    event.preventDefault();

    const ok = confirm("Are you sure?")
    if (!ok) {
      return false;
    }

    this.stimulate("PurchasedAlbumReflex#destroy", event.target)
  }
}

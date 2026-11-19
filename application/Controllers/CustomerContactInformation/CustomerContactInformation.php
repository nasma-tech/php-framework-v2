<?php

namespace App\Controllers\CustomerContactInformation;

use App\Controllers\scheme\ControllerScheme;
use App\Models\CarsBrandModel\CarsBrandModel;
use App\Models\CarsGroupModel\CarsGroupModel;
use App\Models\CityModel\CityModel;
use App\Models\CompaniesModel\CompaniesModel;
use App\Models\ContactAcquisitionSourcesModel\ContactAcquisitionSourcesModel;
use App\Models\ContactPhonesModel\ContactPhonesModel;
use App\Models\ContactProjectRequestsModel\ContactProjectRequestsModel;
use App\Models\ContactProjectsFollowUpModel\ContactProjectsFollowUpModel;
use App\Models\ContactProjectsModel\ContactProjectsModel;
use App\Models\ContactsGroupModel\ContactsGroupModel;
use App\Models\CustomerContactInformationModel\CustomerContactInformationModel;
use App\Models\FollowUpActionsTitleModel\FollowUpActionsTitleModel;
use App\Models\IndustryTypeModel\IndustryTypeModel;
use App\Models\SocialNetworksListModel\SocialNetworksListModel;
use App\Models\StateModel\StateModel;
use InvalidArgumentException;
use Packages\View\handleHttpErrorView;

class CustomerContactInformation extends ControllerScheme
{
    const string singleName = 'مخاطب';
    const string pluralName = 'مخاطبین';
    protected string $defaultModel = CustomerContactInformationModel::class;

    public function main(): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'vendors/js/tables/datatable/datatables.min',
            'vendors/js/tables/datatable/dataTables.bootstrap4.min',
            'vendors/js/tables/datatable/dataTables.buttons.min',
            'vendors/js/tables/datatable/buttons.html5.min',
            'vendors/js/tables/datatable/buttons.print.min',
            'vendors/js/tables/datatable/buttons.bootstrap.min',
            'vendors/js/tables/datatable/jszip.min',
            'vendors/js/tables/datatable/pdfmake.min',
            'vendors/js/tables/datatable/vfs_fonts',
            'vendors/js/tables/datatable/buttons.colVis.min',
            //'js/CustomerContactInformation/CustomerContactInformation'
        ],
            [
                'vendors/css/tables/datatable/datatables.min',
                'css/CustomerContactInformation/CustomerContactInformation'
            ],
            [
                'list' => CustomerContactInformationModel::query()->orderByDesc('id')->get()
            ])->display('CustomerContactInformation/CustomerContactInformation.tpl');
    }

    public function addIndex(): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/CustomerContactInformation/add-CustomerContactInformation',
            'js/CustomerContactInformation/ContactInfo',
            'js/CustomerContactInformation/ContactPhones',
            'js/CustomerContactInformation/ContactProject',
            'js/CustomerContactInformation/ContactFollowUp',
        ], [
            'css/CustomerContactInformation/ContactInfo',
            'css/CustomerContactInformation/followUpStyle',
        ],
            [
                'IndustryType' => IndustryTypeModel::query()->get(),
                'FollowUpActionsTitle' => FollowUpActionsTitleModel::query()->get(),

            ]
        )->display('CustomerContactInformation/add-CustomerContactInformation.tpl');
    }

    public function contactDetail($id = null): void
    {
        try {
            $contactData = CustomerContactInformationModel::with([
                'projectData'
            ])->where('user_id', userObject()->userId)->findOrFail($id);
            view->setPageTitle(self::pluralName);
            view->setSingleName(self::singleName);
            view->setPluralName(self::pluralName);
            view->ui([
                'js/CustomerContactInformation/add-CustomerContactInformation',
                'js/CustomerContactInformation/ContactInfo',
                'js/CustomerContactInformation/ContactPhones',
                'js/CustomerContactInformation/ContactProject',
                'js/CustomerContactInformation/ContactFollowUp',
            ], [
                'css/CustomerContactInformation/ContactInfo',
                'css/CustomerContactInformation/followUpStyle',
            ], [
                'contactData' => $contactData,
                'IndustryType' => IndustryTypeModel::query()->get(),
                'FollowUpActionsTitle' => FollowUpActionsTitleModel::query()->get(),
                'ContactGroups' => ContactsGroupModel::query()->get(),
                'ContactAcquisitionSources' => ContactAcquisitionSourcesModel::query()->get(),
                'states' => StateModel::query()->get(),
                'cities' => CityModel::query()->where('state_id', $contactData->state_id)->get(),
                'contactPhones' => ContactPhonesModel::query()->with([
                    'socialNetworks'
                ])->where('contact_id', $contactData->id)->get(),
                'socialNetWorksList' => SocialNetworksListModel::query()->get(),
            ])->display('CustomerContactInformation/contactDetail.tpl');
        } catch (\Exception $exception) {
            handleHttpErrorView::handle(404, 'مشتری یافت نشد');
        }

    }

    public function contactDetailCall($phoneNumber): void
    {
        switch (strlen($phoneNumber)) {
            case 14:
                $phoneNumber = '0' . substr($phoneNumber, 4);
                break;
            case 13:
                $phoneNumber = '0' . substr($phoneNumber, 3);
                break;
            case 12:
                $phoneNumber = '0' . substr($phoneNumber, 2);
                break;
            case 10:
                $phoneNumber = '0' . $phoneNumber;
                break;
        }
        $phoneSearch = ContactPhonesModel::query()->where('phone_number', $phoneNumber)->first();
        try {
            $contactData = CustomerContactInformationModel::with([
                'projectData'
            ])->where('user_id', userObject()->userId)->findOrFail($phoneSearch->contact_id);
            view->setPageTitle(self::pluralName);
            view->setSingleName(self::singleName);
            view->setPluralName(self::pluralName);
            view->ui([
                'js/CustomerContactInformation/add-CustomerContactInformation',
                'js/CustomerContactInformation/ContactInfo',
                'js/CustomerContactInformation/ContactPhones',
                'js/CustomerContactInformation/ContactProject',
                'js/CustomerContactInformation/ContactFollowUp',
            ], [
                'css/CustomerContactInformation/ContactInfo',
                'css/CustomerContactInformation/followUpStyle',
            ], [
                'contactData' => $contactData,
                'IndustryType' => IndustryTypeModel::query()->get(),
                'FollowUpActionsTitle' => FollowUpActionsTitleModel::query()->get(),
                'ContactGroups' => ContactsGroupModel::query()->get(),
                'ContactAcquisitionSources' => ContactAcquisitionSourcesModel::query()->get(),
                'states' => StateModel::query()->get(),
                'cities' => CityModel::query()->where('state_id', $contactData->state_id)->get(),
                'contactPhones' => ContactPhonesModel::query()->with([
                    'socialNetworks'
                ])->where('contact_id', $contactData->id)->get(),
                'socialNetWorksList' => SocialNetworksListModel::query()->get(),
            ])->display('CustomerContactInformation/contactDetail.tpl');
        } catch (\Exception $exception) {
            redirect('/CustomerContactInformation/addIndex');
        }

    }

    private function generateCustomerCode(): int
    {
        do {
            $code = random_int(100000, 999999);
            $exists = CustomerContactInformationModel::query()->where('contact_code', $code)->exists();
        } while ($exists);
        return $code;
    }

    private function addContactInfo()
    {
        $data = $this->requestArray();
        $this->checkRequired([
            'first_name' => 'نام',
            'last_name' => 'نام خانوادگی',
            'contact_group_id' => 'گروه تماس',
            'contact_acquisition_source_id' => 'نحوه آشنایی',
        ], $data);
        $subscriberData = [
            'contact_type' => $data['contact_type'],
            'first_name' => $data['first_name'],
            'last_name' => $data['last_name'],
            'contact_group_id' => $data['contact_group_id'],
            'contact_acquisition_source_id' => $data['contact_acquisition_source_id'],
            'contact_code' => $this->generateCustomerCode()
        ];
        if ($data['contact_type'] == 1) {
            $this->checkRequired([
                'state_id' => 'استان',
                'city_id' => 'شهر',
            ], $data);
            $dataForm = [
                'national_code' => $data['national_code'],
                'state_id' => $data['state_id'],
                'city_id' => $data['city_id'],
                'user_id' => userObject()->userId,
            ];
            $mergeData = array_merge($subscriberData, $dataForm);
            return CustomerContactInformationModel::query()->create($mergeData)->id;
        } elseif ($data['contact_type'] == 2) {
            $this->checkRequired([
                'national_ID' => 'شناسه ملی'
            ], $data);
            $dataForm = [
                'national_ID' => $data['national_ID'],
                'economic_code' => $data['economic_code'],
                'company_name' => $data['company_name'],
                'establishment_date' => $data['establishment_date'],
                'company_status' => 1,
                'registration_number' => $data['registration_number'],
                'address' => $data['address'],
                'postal_code' => $data['postal_code'],
            ];
            $mergeData = array_merge($subscriberData, $dataForm);
            $addContact = CustomerContactInformationModel::query()->create($mergeData);
            $addCompanies = CompaniesModel::query()->create($dataForm);
            $addContact->companies()->attach($addCompanies->id);
            return $addContact->id;
        } else {
            return false;
        }
    }

    private function addContactPhonesAndSocialNetWorks($contactId): void
    {
        $data = $this->requestArray('contactPhone', []);
        foreach ($data as $item) {
            $this->checkRequired([
                'contact_phone_label_id' => 'عنوان تماس',
                'phone_number' => 'شماره تماس',
            ], $item);

            $socialList = $item['socialList'] ?? [];
            unset($item['socialList']);
            $item['contact_id'] = $contactId;
            $item['user_id'] = userObject()->userId;
            $addPhoneContact = ContactPhonesModel::query()->create($item);
            if (!empty($socialList)) {
                $addPhoneContact->socialNetworks()->attach($socialList);
            }
        }

    }

    public function createProjectCode(int $contactId): string
    {
        $contactProject = ContactProjectsModel::query()->where('contact_id', $contactId)->count();
        return jdate('Y') . $contactId . ($contactProject + 1);
    }

    private function addContactProject(int $contactId)
    {
        $data = $this->requestArray();
        $this->checkRequired([
            'payment_type' => 'نوع پرداخت',
            'purchase_type' => 'نوع خرید',
            'industry_type_id' => 'نوع صنعت',
        ], $data);
        $makeData = [
            'contact_id' => $contactId,
            'project_code' => $this->createProjectCode($contactId),
            'payment_type' => $data['payment_type'],
            'purchase_type' => $data['purchase_type'],
            'industry_type_id' => $data['industry_type_id'],
            'user_id' => userObject()->userId,
        ];
        $addProject = ContactProjectsModel::query()->create($makeData);
        if (isset($data['projectRequest'])) {
            if ($addProject) {
                foreach ($data['projectRequest'] as $item) {
                    ContactProjectRequestsModel::query()->create([
                        'contact_project_id' => $addProject->id,
                        'product_id' => $item['product_id'],
                        'request_amount' => $item['request_amount'],
                        'user_id' => userObject()->userId,
                    ]);
                }
                return $addProject->id;
            } else {
                return false;
            }
        } else {
            return $addProject->id;
        }
    }

    private function addFollowUp(int $contactProjectId): void
    {
        $data = $this->requestArray();
        $this->checkRequired([
            'FollowUp_action_id' => 'عنوان پیگیری بعد'
        ], $data);
        $makeData = [
            'contact_project_id' => $contactProjectId,
            'FollowUp_action_id' => $data['FollowUp_action_id'],
            'next_followUp_date' => dateTimeHelper->convertDateToTimestamp($data['next_followUp_date']),
            'followUp_description' => $data['followUp_description'],
            'user_id' => userObject()->userId
        ];
        ContactProjectsFollowUpModel::query()->create($makeData);
    }

    public function add(): void
    {
        $_ENV['APP_DEBUG'] = 1;
        $addContact = $this->addContactInfo();
        $this->addContactPhonesAndSocialNetWorks($addContact);
        $addContactProject = $this->addContactProject($addContact);
        $this->addFollowUp($addContactProject);
        $this->successCallBack('/CustomerContactInformation/main');
    }
}

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737104;
	b=wz1O1oU9t8WyYRNfhgFrNx4PaWJ9lSeiiEqzfl94xJNFzvWVaoc7f05KNmGLLxEprZw5
	 zrScWO1E0U8fIQ8wXLF7quZSW8ZjS7g5t5F2tbFKny7XiP1FMZa5qodjVFeJKG/BrHoHt
	 f8FKIuriiS7qhpRNmG8PpWl3+DVWw7S5OWXCyqpPmIrNGk6HqRJzJdTTY01HdYxyvpXbj
	 6HaDmVi6W7VHUZOsoaYYi+WoO3IRzu9per+z+Es271qTWBP3tI05b9houS1QJ7wpWEzKU
	 7sexeHy1KzHl6mSPQdRrjE7AvM9v6HagVfA0/FcXwT3dEgh3Z8MgXpd0K/iV6lmcioQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737104;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=33tGxL4pQ37PAm6R2PA7y86/iQoPs+fP5QCASbIaiW4=;
	b=jyCfNX/9+H5yQkwskBT3ZGARxUxA/9LCOy0PtjrR0VTahkyNjJqWt4F1t38TgyEvzc/L
	 re1tYzsgmu3Ancoz2sLPQa1ehdGLnD7/zmfUiD/br4LxDDN4CX0nYEWsru9+p+xe/3WwU
	 CG4kGC1V+4ky9hHrkA0v4LoZHlXjHw7hmB/plee2NdU4JZVhJ051iLxlvN5Aa6SnxlDeT
	 61c+Ck0Vkwsp8NR6ByAdByfFZDJnUmHPvWLEPjbpbuJ0m17wbn2CJo2qZe/B7R0TJ4cLs
	 t0ALNuQOmIPsM1BKXhfjWyPcqb82zE+hSEkTKPyKMWPxuhy//yn7QtgK0/CTDzA7SOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fjsQ8MHy;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3E8606A31A;
	Fri, 23 Oct 2026 06:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B3E8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fjsQ8MHy
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=33tGxL4pQ37PAm6R2PA7y86/iQoPs+fP5QCASbIaiW4=;
	b=fjsQ8MHyFLg2DKpb+rChWOhrQ6Agx+aJ4B3WloBfzhk5I42lfFR8N28XAuSRbTqFZgHgChm3O
	4OwNSVOJK87cDrNiMupTVhF9pAM7IdBGhA0OswOr1fHmf/8LmJiA8sNJ5JxoASQ+9LC7G7GDo6P
	DlcW4ZEJB+N+XLWejTOA2kU=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4j9tTJ65BLzLlX6;
	Fri, 23 Oct 2026 14:31:32 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 10C6B40594;
	Fri, 23 Oct 2026 14:31:36 +0800 (CST)
Received: from [10.67.110.140] (10.67.110.140) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 23 Oct 2026 14:31:29 +0800
Message-ID: <a2832263-3e3b-4d05-98bd-dc006d5be689@huawei.com>
Date: Fri, 23 Oct 2026 14:31:28 +0800
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 01/18] fs: pass struct path to notify_change()
To: Christian Brauner <brauner@kernel.org>
CC: <mic@digikod.net>, <gnoack@google.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <serge@hallyn.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
	<rdunlap@infradead.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <johan@kernel.org>, <dlemoal@kernel.org>, <hch@lst.de>,
	<axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <jack@suse.cz>,
	<dhowells@redhat.com>, <code@tyhicks.com>, <linkinjeon@kernel.org>,
	<sj1557.seo@samsung.com>, <yuezhang.mo@sony.com>,
	<hirofumi@mail.parknet.co.jp>, <cel@kernel.org>, <jlayton@kernel.org>,
	<neil@brown.name>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <hyc.lee@gmail.com>, <miklos@szeredi.hu>,
	<amir73il@gmail.com>, <senozhatsky@chromium.org>,
	<chenxiaosong@chenxiaosong.com>, <kpsingh@kernel.org>, <matt@bobrowski.net>,
	<rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <john.johansen@canonical.com>,
	<georgia.garcia@canonical.com>, <zohar@linux.ibm.com>,
	<roberto.sassu@huawei.com>, <dmitry.kasatkin@gmail.com>,
	<eric.snowberg@oracle.com>, <stephen.smalley.work@gmail.com>,
	<omosnacek@gmail.com>, <casey@schaufler-ca.com>, <takedakn@nttdata.co.jp>,
	<penguin-kernel@i-love.sakura.ne.jp>, <xiujianfeng@huawei.com>,
	<nanx95726@gmail.com>, <djwong@kernel.org>, <lujialin4@huawei.com>,
	<bpf@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<driver-core@lists.linux.dev>, <linux-block@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <netfs@lists.linux.dev>,
	<ecryptfs@vger.kernel.org>, <exfat@lists.linux.dev>,
	<linux-nfs@vger.kernel.org>, <ntfs@lists.linux.dev>,
	<linux-unionfs@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <apparmor@lists.ubuntu.com>,
	<linux-integrity@vger.kernel.org>, <selinux@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-2-caixinchen1@huawei.com>
 <20261021-nanotechnologie-gebadet-gepaukt-52a950759f0a@brauner>
Content-Language: en-US
From: Cai Xinchen <caixinchen1@huawei.com>
In-Reply-To: <20261021-nanotechnologie-gebadet-gepaukt-52a950759f0a@brauner>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemk100010.china.huawei.com (7.152.184.41)

Thanks for the explanation, you are right.  I will restore the idmap as 
a separate argument

On 10/21/2026 6:21 PM, Christian Brauner wrote:
> On Thu, Oct 15, 2026 at 08:54:07PM +0800, Cai Xinchen wrote:
>> notify_change() takes a struct mnt_idmap and a struct dentry even
>> though all of its callers either already hold a struct path (or a
>> struct file) or have to pass &nop_mnt_idmap because no idmapped
>> mount is involved.  Switch the helper and its declaration to take a
>> struct path instead and derive the idmap and dentry from it.
> No, the idmap needs to be passed separately. The whole point is that
> during path lookup mnt->mnt_idmap can change. So mnt->mnt_idmap is taken
> of the mount at the time it was checked and passed down to the
> filesystem so that the VFS and the filesystem are guaranteed to see the
> same idmap.

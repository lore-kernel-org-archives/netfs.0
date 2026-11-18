Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993225;
	b=cy6vbRrO+kEE3mg1dH2bc3UeUHIiWd8IWnaOYSMwfuGdG22u1sEwNwroEd5xpY5goV6M
	 mNEt0xAqvIYm9YAn2RGqiU4u4V3h7A2I11sXJBoJ4KOsO8hs9t1vk6QGpy6INBHbv8vQU
	 qNDqpuMq4s9/FmDJTSWfJF/7RfIzgaXmpHCdxaYui+8PzZyExfA4aviZVgA+lnklBT34z
	 W2c5Oi2zcdtWEprPM33dExDVvCo35kA5WYIDhu6XO8yo0T1G5IdoD7LjLj4mWywyEDrJR
	 wOW5isdT2pH3iN8WFzhBDVb7cL+GpUxErqd836UH8pkd0WGex/i9jGNHd+EDJR5sryQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993225;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=gqPBU5vSzctPXUMsg32k86Yb/Qp3EYKKyTavFdf5sH8=;
	b=AXXdP7+OhCVqWCqIhmXLmDBQaMpspPDBOdzegCWpvXPdCRLGmDH7i7FEtG+rGnym+nsJ
	 totnDK/Jjz7jJP+zaF9lph7KhBK6LMTWYit1DGCFPcB5Q5y/waXM9MCasv9t0htStW1Dh
	 ekoblDVyf1FuG4EfWNOMCeHvYZRSryTV1tT4wovSHIXofMELga/oTrqkic2vnEMXrESgp
	 QSKzrRfidj5rhpvsurlQs6kPWWeahkbajQhefdSrr0SmpbIpucHliSDydJVatgTsP5+A5
	 hPR4fNHCm2X8ZnxyY8rH9vn+Ke34FhiT77K7Bja/oxu+KfnqhGY1eIvE2C8cI7k4F7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=u7vlY2Tx;
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0176A60A2616;
	Wed, 18 Nov 2026 09:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0176A60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=u7vlY2Tx
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gqPBU5vSzctPXUMsg32k86Yb/Qp3EYKKyTavFdf5sH8=;
	b=u7vlY2TxckHQP+tYQthSmXBs8/AgddjDNh8bkjwDxaHhPAcGONyr849lvDagg0uq2tPODQr+O
	RNkZ/GSkSnHrw23pVJBgD4eBpcXClBJwejVje/VjYL1bZHv0QSts4KMpbezyGFZ04qUx8679+NR
	1cZfatNyiz6HsIFs9LF+vZQ=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jTwr60sQjzKmVb;
	Wed, 18 Nov 2026 17:13:26 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D73B40561;
	Wed, 18 Nov 2026 17:13:40 +0800 (CST)
Received: from [10.67.110.140] (10.67.110.140) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 18 Nov 2026 17:13:33 +0800
Message-ID: <32b8d9c9-27d2-4da9-8618-ccfc44dee7a3@huawei.com>
Date: Wed, 18 Nov 2026 17:13:31 +0800
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
Subject: Re: [PATCH -next -v4 01/17] fs: pass struct path to notify_change()
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <mic@digikod.net>, <gnoack@google.com>, <paul@paul-moore.com>,
	<brauner@kernel.org>, <jack@suse.cz>, <amir73il@gmail.com>,
	<andrii@kernel.org>, <apparmor@lists.ubuntu.com>, <ast@kernel.org>,
	<axboe@kernel.dk>, <bpf@vger.kernel.org>, <casey@schaufler-ca.com>,
	<cel@kernel.org>, <cem@kernel.org>, <chenxiaosong@chenxiaosong.com>,
	<code@tyhicks.com>, <corbet@lwn.net>, <Dai.Ngo@oracle.com>,
	<dakr@kernel.org>, <daniel@iogearbox.net>, <dhowells@redhat.com>,
	<dlemoal@kernel.org>, <dmitry.kasatkin@gmail.com>,
	<driver-core@lists.linux.dev>, <dsterba@suse.com>,
	<ecryptfs@vger.kernel.org>, <eddyz87@gmail.com>, <emil@etsalapatis.com>,
	<eric.snowberg@oracle.com>, <exfat@lists.linux.dev>,
	<georgia.garcia@canonical.com>, <gregkh@linuxfoundation.org>, <hch@lst.de>,
	<hirofumi@mail.parknet.co.jp>, <hyc.lee@gmail.com>,
	<ihor.solodrai@linux.dev>, <jlayton@kernel.org>, <jmorris@namei.org>,
	<johan@kernel.org>, <john.fastabend@gmail.com>,
	<john.johansen@canonical.com>, <jolsa@kernel.org>, <kpsingh@kernel.org>,
	<linkinjeon@kernel.org>, <linux-api@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-unionfs@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <liubaolin12138@163.com>,
	<martin.lau@linux.dev>, <mason@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<matt@bobrowski.net>, <memxor@gmail.com>, <mhiramat@kernel.org>,
	<miklos@szeredi.hu>, <neil@brown.name>, <netfs@lists.linux.dev>,
	<ntfs@lists.linux.dev>, <okorniev@redhat.com>, <omosnacek@gmail.com>,
	<penguin-kernel@i-love.sakura.ne.jp>, <rafael@kernel.org>,
	<rdunlap@infradead.org>, <roberto.sassu@huawei.com>, <rostedt@goodmis.org>,
	<selinux@vger.kernel.org>, <senozhatsky@chromium.org>, <serge@hallyn.com>,
	<sj1557.seo@samsung.com>, <skhan@linuxfoundation.org>, <song@kernel.org>,
	<stephen.smalley.work@gmail.com>, <takedakn@nttdata.co.jp>, <tom@talpey.com>,
	<yonghong.song@linux.dev>, <yuezhang.mo@sony.com>, <zohar@linux.ibm.com>,
	<utilityemal77@gmail.com>, <lujialin4@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-2-caixinchen1@huawei.com>
 <20261117183059.GP989762@ZenIV>
Content-Language: en-US
From: Cai Xinchen <caixinchen1@huawei.com>
In-Reply-To: <20261117183059.GP989762@ZenIV>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk100010.china.huawei.com (7.152.184.41)

On whether we want the mount references at all: they are not for NTFS.
The path-based LSM hooks need them - Landlock's check walks the hierarchy
up from the object with path->mnt->mnt_root and follow_up(), for every
layer, and the idmap we pass has to be the one of the mount the path was
checked in.  NTFS is only the reason for ia_path/notify_change_target():
->setattr() has no path argument, so a change forwarded to the base inode
would otherwise lose the mount.

On 11/18/2026 2:30 AM, Al Viro wrote:
> That needs a bit along the lines of "path MUST be consistent - don't combine
> a dentry from one filesystem with mount of another".  All in-kernel callers
> might have appropriate struct mount references on hand, but for out-of-tree
> code that might be not true and we'd better be upfront about the headache
> we are inflicting.
>
> I'm not sure we really want to provide those mount references, TBH - it does
> add a constraint not just on out-of-tree callers, but upon the future uses
> in the kernel.  If NTFS is the only reason... ugh.

ok, I will change in v5

> BTW, why not something like
>
> 		notify_change(&nop_mnt_idmap,
> 			      &(struct path){.mnt = path.mnt, .dentry = dentry},
> 			      &newattrs, NULL);
> instead of that named local?  Same question for other places like that...



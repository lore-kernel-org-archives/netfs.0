Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993434;
	b=DuOljkuICpGRohSi7aitP7JeO78KOVB/oDcyH++9Dxdio3w+cR01NBTgb7EOfmNR7Qk/
	 HVgdoNDPqfQ8n5eCUuwklnTPRHZfKRDV5y+C3rXmDAifhMGkOJrMvlB9PUotpG9Fi1a0H
	 YiS+xQdy1fffpmTpgBgX/+CQTWRR/AR2uakag8Ycm3tiFs8RMRm/11bShjnLq8vdCytkh
	 ObJZOx0E7+CX+0Tgf9ClLMGYYBR/9WdFmlMduCoN8RwfVMtR7ICQHIm5qDYwuBpUmHytl
	 /yHzqO0cK10/GD6F7/XVWNIc+49yyCB1YERUD86TTtl3A+LMAdEC+j4oUUyBBAUG8TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993434;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=xsIsDZiCZyB7+lKhnSB47LX6hbKq7VMg+O30s3v8xU0=;
	b=blMxYa9a8CyzqmybZfDPZJG6xWRdMr4BMfNiYxKfvabExelg6NcZaQ/pmGNVpiLeNTex
	 pxJSrd2zMj7ZF1M50jIqBUmT/gtIprVL/lCqZDkRrR0VDi7lHd5INHCPG+dB+S0mEJRsp
	 +6qfVRVpL18spsROkPKyN6nToGvyr3Br1tBW1BQ8whljAHX46Yxf+tcFYDyy82Tb+PRc/
	 yaR05sSWJXIb9AejVRM+XgCPOO+IBcnDf/GlnQNW8FD/UZ8oBNVfzFF545nY/n7Dawqt3
	 jQ3oSqhGLai+pfcyjfIVMpj6Ah/PYs5WBRLngv4uV5lDrzZsnncwriFer89067q7zJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PV3E+oEf;
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED8606A320;
	Wed, 18 Nov 2026 09:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03ED8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PV3E+oEf
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xsIsDZiCZyB7+lKhnSB47LX6hbKq7VMg+O30s3v8xU0=;
	b=PV3E+oEfe6GWTlN7IzcOZNtMuGokpGaMaE5HT+w5Vk98jOWnb53YzhdAAkTed93AvGp6D+ngZ
	ftGk2P047j6/rbz8Ke0Kewk86yZLKYBKuM/FH/uksdfAvh6qdTvxfoyU41EsmNujsw5oLc+20hb
	oGEWnwe8RZuneZEt42a2+8c=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jTww76jtyzKm8G;
	Wed, 18 Nov 2026 17:16:55 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 41D7540586;
	Wed, 18 Nov 2026 17:17:10 +0800 (CST)
Received: from [10.67.110.140] (10.67.110.140) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 18 Nov 2026 17:17:02 +0800
Message-ID: <61823b38-032d-4e4c-bcbb-82fe83c34ade@huawei.com>
Date: Wed, 18 Nov 2026 17:17:01 +0800
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
 <20261117183059.GP989762@ZenIV> <20261117183440.GQ989762@ZenIV>
Content-Language: en-US
From: Cai Xinchen <caixinchen1@huawei.com>
In-Reply-To: <20261117183440.GQ989762@ZenIV>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk100010.china.huawei.com (7.152.184.41)

Yes.  ovl_do_notify_change() passes
ovl_upper_mnt(ofs) together with the real upperdentry, so the sb matches,
and the idmap handed down is ovl_upper_mnt_idmap(ofs), i.e. taken from
that very mount.  It runs under with_ovl_creds(), like the other ovl_do_*
forwards, so an LSM sees a genuine upper-layer path instead of a merged
dentry whose mount we cannot name - which is the point of converting the
metadata helpers.

On 11/18/2026 2:34 AM, Al Viro wrote:
> Incidentally, will the mount reference you are supplying in case of overlayfs
> upper layer be any good for LSM users?
